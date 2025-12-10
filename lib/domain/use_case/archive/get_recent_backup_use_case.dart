import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:whispr/domain/repository/archive_repository.dart';
import 'package:whispr/util/constants.dart';

@injectable
class GetRecentBackupUseCase {
  const GetRecentBackupUseCase(this._archiveRepository);

  final ArchiveRepository _archiveRepository;

  Future<File?> call() {
    return _archiveRepository.getRecentBackup(
      timeoutPeriod: WhisprDuration.recentBackupTimeout,
    );
  }
}
