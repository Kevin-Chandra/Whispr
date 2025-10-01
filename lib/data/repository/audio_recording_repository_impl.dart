import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/data/local/database/audio_recording_local_indexable_database.dart';
import 'package:whispr/data/local/file_service.dart';
import 'package:whispr/data/mappers/audio_recording_mapper.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/audio_recording_repository.dart';
import 'package:whispr/util/constants.dart';

@Injectable(as: AudioRecordingRepository)
class AudioRecordingRepositoryImpl implements AudioRecordingRepository {
  AudioRecordingRepositoryImpl(this.database, this._fileService);

  final AudioRecordingLocalIndexableDatabase database;
  final FileService _fileService;

  @override
  Future<Either<bool, FailureEntity>> saveAudioRecording(
      AudioRecording audioRecording,) async {
    try {
      final response = await database.createRecord(audioRecording.mapToModel());
      return left(response);
    } catch (e) {
      Constants.logger.e(e);
      return right(FailureEntity(error: e.toString()));
    }
  }

  @override
  Future<Either<bool, FailureEntity>> updateAudioRecording(
      AudioRecording audioRecording) async {
    try {
      final response = await database.updateRecord(audioRecording.mapToModel());
      return left(response);
    } catch (e) {
      Constants.logger.e(e);
      return right(FailureEntity(error: e.toString()));
    }
  }

  @override
  Future<Either<bool, FailureEntity>> deleteAudioRecording(String id) async {
    try {
      final audioRecording = await database.getAudioRecording(id);
      if (audioRecording == null) {
        return right(FailureEntity(
            error: "Delete Error!",
            errorDescription: "Audio recording not found"));
      }

      final response = await database.deleteRecord(audioRecording.id);
      if (response == false) {
        return right(FailureEntity(
            error: "Delete Error!",
            errorDescription: "Audio recording not found"));
      }

      final deleteFileResponse =
      await deleteAudioRecordingFile(audioRecording.filePath);
      return deleteFileResponse;
    } catch (e) {
      Constants.logger.e(e);
      return right(FailureEntity(
          error: "Delete Error!", errorDescription: e.toString()));
    }
  }

  @override
  Stream<List<AudioRecording>> getAllRecordings() {
    return database.watchRecordings().map((i) {
      final list = i.map((recording) => recording.mapToDomain()).toList();
      list.sort((recording1, recording2) =>
          recording1.createdAt.compareTo(recording2.createdAt));
      return list;
    });
  }

  @override
  Future<Either<bool, FailureEntity>> deleteAudioRecordingFile(
      String filePath) async {
    try {
      final response = await _fileService.deleteFile(filePath);
      return left(response);
    } on Exception catch (e) {
      Constants.logger.e(e);
      return right(FailureEntity(error: e.toString()));
    }
  }

  @override
  Future<Either<List<AudioRecording>, FailureEntity>> getRecordingsByDate(
      DateTime date) async {
    try {
      final response = database
          .getRecordByDate(date)
          .map((recording) => recording.mapToDomain())
          .toList();
      response.sort((recording1, recording2) =>
          recording1.createdAt.compareTo(recording2.createdAt));
      return left(response);
    } catch (e) {
      Constants.logger.e(e);
      return right(FailureEntity(error: e.toString()));
    }
  }

  @override
  Future<Either<List<AudioRecording>, FailureEntity>> getRecordingsByFavourite(
      bool isFavourite) async {
    try {
      final response = database
          .getRecordByBoolean(isFavourite)
          .map((recording) => recording.mapToDomain())
          .toList();
      response.sort((recording1, recording2) =>
          recording1.createdAt.compareTo(recording2.createdAt));
      return left(response);
    } catch (e) {
      Constants.logger.e(e);
      return right(FailureEntity(error: e.toString()));
    }
  }

  @override
  Future<Either<AudioRecording, FailureEntity>> getAudioRecordingById(
      String id) async {
    final response = await database.getAudioRecording(id);
    if (response == null) {
      return right(FailureEntity(error: "Audio recording not found"));
    } else {
      return left(response.mapToDomain());
    }
  }
}
