import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/data/local/database/audio_recording_local_indexable_database.dart';
import 'package:whispr/data/local/file_service.dart';
import 'package:whispr/data/local/hive/whispr_hive_db_keys.dart';
import 'package:whispr/data/models/audio_recording_model.dart';
import 'package:whispr/data/models/recording_tag_model.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/archive_repository.dart';
import 'package:whispr/util/constants.dart';

@Injectable(as: ArchiveRepository)
class ArchiveRepositoryImpl implements ArchiveRepository {
  const ArchiveRepositoryImpl(
    @Named(WhisprHiveDbKeys.recordingTagBoxKey) this.recordingTagBox,
    this.database,
    this._fileService,
  );

  final AudioRecordingLocalIndexableDatabase database;
  final Box<RecordingTagModel> recordingTagBox;
  final FileService _fileService;

  @override
  Future<Either<File, FailureEntity>> backupRecordings({
    required String fileName,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final appDirectory = await _fileService.getDefaultDirectory();
      final isBackupFileExist = await _fileService.isFileExist(
        "$appDirectory/${FileConstants.backupDirectory}/$fileName${FileConstants.archiveFileExtension}",
      );
      if (isBackupFileExist) {
        throw Exception("Backup file with name $fileName already exist");
      }

      Constants.logger.i("Starting backup operation");

      // 1. Find all the recordings;
      final recordings = await database.getRecordByDateRange(
          startDate: startDate, endDate: endDate);

      // 2. Delete and recreate temporary directory.
      await _fileService.deleteDirectory(
        FileConstants.backupTemporaryDirectory,
        recursive: true,
      );
      await _fileService
          .createDirectory(FileConstants.backupTemporaryRecordingsDirectory);

      // 3. Validate any recordings without audio file.
      var filteredRecordings = recordings;
      final recordingsWithoutFile = (await Future.wait(
        recordings.map(
          (recording) async {
            final isFileExist =
                await _fileService.isFileExist(recording.filePath);
            return isFileExist ? null : recording;
          },
        ),
      ))
          .whereType<AudioRecordingModel>()
          .toList();

      // If there is any recording without audio file, skip them.
      if (recordingsWithoutFile.isNotEmpty) {
        filteredRecordings = recordings
            .where((recording) => !recordingsWithoutFile.contains(recording))
            .toList();

        final recordingNameAndId = recordingsWithoutFile
            .map((recording) => "Name: ${recording.name}, ID: ${recording.id}")
            .join("\n");

        Constants.logger.w(
          "Skipping backup for recording(s) without audio file\n"
          "Following audio file are missing: \n$recordingNameAndId",
        );
      }
      Constants.logger
          .i("Found ${filteredRecordings.length} recording(s) to backup");

      // 3. Copy all the recordings to the temporary directory.
      await Future.wait(
          filteredRecordings.map((recording) => _fileService.copyFile(
                recording.filePath,
                "${FileConstants.backupTemporaryRecordingsDirectory}/${recording.id}${FileConstants.audioFileExtension}",
              )));

      // 4. Create json file for all the recordings metadata.
      final recordingsMetadataFile = await _fileService.createFile(
          "${FileConstants.backupTemporaryDirectory}/${FileConstants.recordingBackupFile}");

      // 5. Modify recording file path;
      final newRecordings = filteredRecordings
          .map((recording) => recording.copyWith(
              filePath: "${recording.id}${FileConstants.audioFileExtension}"))
          .toList();
      await recordingsMetadataFile.writeAsString(json.encode(newRecordings));

      // 6. Backup recording tag data.
      final recordingTags = recordingTagBox.values.toList();
      final recordingTagsMetadataFile = await _fileService.createFile(
          "${FileConstants.backupTemporaryDirectory}/${FileConstants.recordingTagBackupFile}");
      await recordingTagsMetadataFile.writeAsString(json.encode(recordingTags));

      // 7. Bundle the directory into a file.
      final archivedFile = await _fileService.archiveDirectory(
        inputPath: FileConstants.backupTemporaryDirectory,
        outputPath:
            "${FileConstants.backupDirectory}/$fileName${FileConstants.archiveFileExtension}",
      );
      Constants.logger.i("Backup file created");

      // 8.Delete temporary directory.
      await _fileService.deleteDirectory(
        FileConstants.backupTemporaryDirectory,
        recursive: true,
      );
      Constants.logger.i("Temporary backup directory deleted");

      return left(archivedFile);
    } on Exception catch (e, s) {
      Constants.logger.e("Backup operation failed\n$e\n$s");
      return right(FailureEntity(error: e.toString()));
    }
  }

  @override
  Future<Either<bool, FailureEntity>> restoreRecordings({
    required String filePath,
  }) async {
    try {
      // TODO: Add validation to zip file.
      Constants.logger.i("Starting restore operation");

      // 1. Make sure all the temporary backup directory are deleted.
      await _fileService.deleteDirectory(
        FileConstants.backupTemporaryDirectory,
        recursive: true,
      );

      Constants.logger.i("Extract zip file");
      // 2. Unzip the backup file.
      if (!await _fileService.isFileExist(filePath)) {
        throw Exception("Backup file not found!");
      }
      await _fileService.extractArchived(
        inputPath: filePath,
        outputPath: FileConstants.backupTemporaryDirectory,
      );
      Constants.logger.i("Backup file extracted!");

      // 3. Verify all required files exists.
      final appDirectory = await _fileService.getDefaultDirectory();
      final backupTemporaryPath =
          "$appDirectory/${FileConstants.backupTemporaryDirectory}";

      final recordingsMetadataFile =
          File("$backupTemporaryPath/${FileConstants.recordingBackupFile}");
      if (!await recordingsMetadataFile.exists()) {
        throw Exception("Recordings metadata file not found");
      }
      final recordingTagsMetadataFile =
          File("$backupTemporaryPath/${FileConstants.recordingTagBackupFile}");
      if (!await recordingTagsMetadataFile.exists()) {
        throw Exception("Recording tag metadata file not found");
      }

      // Verify audio files exist
      final audioSubDirectory = await _fileService
          .getDirectory(FileConstants.backupTemporaryRecordingsDirectory);
      if (audioSubDirectory == null) {
        throw Exception("Audio sub directory not found");
      }

      // 4. Read json files
      final recordingTagsJson = await recordingTagsMetadataFile.readAsString();
      final recordingTags =
          RecordingTagModel.fromJsonList(jsonDecode(recordingTagsJson));
      final recordingTagMap = {for (var tag in recordingTags) tag.id: tag};
      Constants.logger
          .i("Found ${recordingTagMap.length} recording tag(s) to restore");

      final audioRecordingJson = await recordingsMetadataFile.readAsString();
      final audioRecordings =
          AudioRecordingModel.fromJsonList(jsonDecode(audioRecordingJson));
      Constants.logger
          .i("Found ${audioRecordings.length} audio recording(s) to restore");

      // Modify the audio recording filePath
      final modifiedAudioRecordings = audioRecordings
          .map(
            (recording) => recording.copyWith(
              filePath:
                  "$appDirectory/${FileConstants.audioDirectoryName}/${recording.id}${FileConstants.audioFileExtension}",
            ),
          )
          .toList();

      // 5. Delete all files in audio directory.
      await _fileService.deleteDirectory(
        FileConstants.audioDirectoryName,
        recursive: true,
      );
      Constants.logger.i("Cleaned up audio file directory");

      // 6. Move all audio files to default audio directory.
      await _fileService.createDirectory(FileConstants.audioDirectoryName);
      await for (final file in audioSubDirectory.list(recursive: false)) {
        if (file is! File) {
          // Skip if not a file (i.e. a directory, etc.).
          continue;
        }

        final fileName = _fileService.getFileName(file.path);
        _fileService.moveFile(
          file,
          "$appDirectory/${FileConstants.audioDirectoryName}/$fileName",
        );
      }
      Constants.logger.i("Moved backup audio files to audio directory");

      // 7. Delete the box.
      await recordingTagBox.clear();
      await database.clearDatabase();
      Constants.logger.i("Cleared database");

      // 8. Bulk import
      await recordingTagBox.putAll(recordingTagMap);
      await database.bulkInsert(modifiedAudioRecordings);
      Constants.logger.i("Imported all backup files to database");

      // 9. Delete temporary directory.
      await _fileService.deleteDirectory(
        FileConstants.backupTemporaryDirectory,
        recursive: true,
      );
      Constants.logger.i("Temporary backup directory deleted");

      return left(true);
    } on Exception catch (e, s) {
      Constants.logger.e("Restore operation failed\n$e\n$s");
      return right(FailureEntity(error: e.toString()));
    }
  }
}
