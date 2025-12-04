import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/archive_repository.dart';

@injectable
class BackupRecordingsUseCase {
  const BackupRecordingsUseCase(this._archiveRepository);

  final ArchiveRepository _archiveRepository;

  Future<Either<File, FailureEntity>> call({
    required String fileName,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return _archiveRepository.backupRecordings(
      fileName: fileName,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
