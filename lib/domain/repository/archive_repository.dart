import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:whispr/domain/entities/failure_entity.dart';

abstract class ArchiveRepository {
  Future<Either<File, FailureEntity>> backupRecordings({
    required String fileName,
    DateTime? startDate,
    DateTime? endDate,
  });

  Future<Either<bool, FailureEntity>> restoreRecordings({
    required String filePath,
  });

  Future<int> getRecordCountByDateRange({
    required DateTime startDate,
    required DateTime endDate,
  });

  Future<Either<bool, FailureEntity>> clearAllBackups();
}
