import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/date_time_util.dart';

@injectable
class FileService {
  Future<String> createAudioPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final audioDirectory =
        Directory("${directory.path}/${FileConstants.audioDirectoryName}");
    if (!await audioDirectory.exists()) {
      await audioDirectory.create(recursive: true);
    }

    final timestamp =
        DateTimeHelper.getCurrentTimestamp(DateFormatConstants.fileTimestamp);

    return "${audioDirectory.path}/${FileConstants.audioFileHeaderName}_$timestamp${FileConstants.audioFileExtension}";
  }

  Future<String> getDefaultDirectory() async {
    return (await getApplicationDocumentsDirectory()).path;
  }

  Future<bool> isFileExist(String filePath) async {
    final file = File(filePath);
    return await file.exists();
  }

  Future<bool> deleteFile(String filePath) async {
    final file = File(filePath);
    await file.delete();
    return true;
  }

  Future<File> createFile(String filePath) async {
    final appPath = await getApplicationDocumentsDirectory();
    return File("${appPath.path}/$filePath").create();
  }

  Future<File> copyFile(String sourcePath, String destinationPath) async {
    final appPath = await getApplicationDocumentsDirectory();
    final sourceFile = File(sourcePath);
    return await sourceFile.copy("${appPath.path}/$destinationPath");
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      // Attempt to rename the file (faster if on the same file system)
      return await sourceFile.rename(newPath);
    } on FileSystemException catch (e) {
      // If rename fails (e.g., different file systems), copy and then delete
      final newFile = await sourceFile.copy(newPath);
      await sourceFile.delete();
      return newFile;
    }
  }

  String getFileName(String filePath) {
    return basename(filePath);
  }

  Future<Directory?> getDirectory(String path) async {
    final appPath = await getApplicationDocumentsDirectory();
    final directory = Directory("${appPath.path}/$path");
    if (!(await directory.exists())) {
      return null;
    }
    return directory;
  }

  Future<Directory> createDirectory(String path) async {
    final appPath = await getApplicationDocumentsDirectory();
    final directory = Directory("${appPath.path}/$path");
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    return directory;
  }

  Future<bool> deleteDirectory(String path, {bool recursive = false}) async {
    final appPath = await getApplicationDocumentsDirectory();
    final directory = Directory("${appPath.path}/$path");

    if (!(await directory.exists())) {
      return false;
    }

    await directory.delete(recursive: recursive);
    return true;
  }

  Future<File> archiveDirectory({
    required String inputPath,
    required String outputPath,
  }) async {
    final appPath = await getApplicationDocumentsDirectory();
    final inputDirectory = Directory("${appPath.path}/$inputPath");
    final zipFile = File("${appPath.path}/$outputPath");

    await ZipFile.createFromDirectory(
      sourceDir: inputDirectory,
      zipFile: zipFile,
      recurseSubDirs: true,
    );
    return zipFile;
  }

  Future<Directory> extractArchived({
    required String inputPath,
    required String outputPath,
  }) async {
    final zipFile = File(inputPath);
    final directory = await createDirectory(outputPath);

    await ZipFile.extractToDirectory(
      zipFile: zipFile,
      destinationDir: directory,
    );

    return directory;
  }

  Future<List<File>?> getFilesInAppDirectory({required String path}) async {
    final appPath = await getApplicationDocumentsDirectory();
    final directory = Directory("${appPath.path}/$path");

    if (!await directory.exists()) {
      return null;
    }

    return await directory
        .list(recursive: false)
        .where((element) => element is File)
        .map((e) => e as File)
        .toList();
  }
}
