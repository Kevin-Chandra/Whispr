import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:whispr/domain/entities/failure_entity.dart';

@injectable
class SaveFileToDirectoryUseCase {
  const SaveFileToDirectoryUseCase();

  Future<Either<bool, FailureEntity>> call({required File file}) async {
    try {
      final directoryPath = await FilePicker.platform.getDirectoryPath();
      if (directoryPath == null) {
        return left(false);
      }

      final fileName = p.basename(file.path);
      await file.copy("$directoryPath/$fileName");

      return left(true);
    } on Exception catch (e, s) {
      return right(FailureEntity(error: e.toString()));
    }
  }
}
