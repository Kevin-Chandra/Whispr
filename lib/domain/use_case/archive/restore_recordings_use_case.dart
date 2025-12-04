import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/archive_repository.dart';

@injectable
class RestoreRecordingsUseCase {
  const RestoreRecordingsUseCase(this._archiveRepository);

  final ArchiveRepository _archiveRepository;

  Future<Either<bool, FailureEntity>> call(String filePath) {
    return _archiveRepository.restoreRecordings(filePath: filePath);
  }
}
