import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/archive_repository.dart';
import 'package:whispr/domain/repository/audio_recording_repository.dart';
import 'package:whispr/domain/repository/recording_tag_repository.dart';

@injectable
class ClearAllDataUseCase {
  const ClearAllDataUseCase(
    this._audioRecordingRepository,
    this._recordingTagRepository,
    this._archiveRepository,
  );

  final AudioRecordingRepository _audioRecordingRepository;
  final RecordingTagRepository _recordingTagRepository;
  final ArchiveRepository _archiveRepository;

  Future<Either<bool, FailureEntity>> call() async {
    final response = await Future.wait([
      _archiveRepository.clearAllBackups(),
      _audioRecordingRepository.clearAllData(),
      _recordingTagRepository.clearAllTags(),
    ]);

    if (response.any((r) => r.isRight())) {
      final errorMessage = response
          .where((r) => r.isRight())
          .map((r) => r.getOrElse(FailureEntity.empty).error)
          .join("\n");

      return right(FailureEntity(error: errorMessage));
    }

    return left(true);
  }
}
