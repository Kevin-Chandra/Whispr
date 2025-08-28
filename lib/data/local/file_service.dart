import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/date_time_util.dart';

@injectable
class FileService {
  static const audioDirectoryName = 'audio_recordings';
  static const audioFileExtension = '.m4a';
  static const audioFileHeaderName = 'audio_recording';

  Future<String> createAudioPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final audioDirectory = Directory("${directory.path}/$audioDirectoryName");
    if (!await audioDirectory.exists()) {
      await audioDirectory.create(recursive: true);
    }

    final timestamp =
        DateTimeHelper.getTimestamp(DateFormatConstants.fileTimestamp);

    return "${audioDirectory.path}/${audioFileHeaderName}_$timestamp$audioFileExtension";
  }

  Future<bool> isFileExist(String filePath) async {
    final file = File(filePath);
    return await file.exists();
  }
}
