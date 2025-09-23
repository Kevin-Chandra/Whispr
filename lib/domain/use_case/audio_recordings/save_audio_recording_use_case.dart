import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/entities/mood.dart';
import 'package:whispr/domain/repository/audio_recording_repository.dart';
import 'package:whispr/util/uuid_util.dart';

@injectable
class SaveAudioRecordingUseCase {
  SaveAudioRecordingUseCase(this._audioRecordingRepository);

  final AudioRecordingRepository _audioRecordingRepository;

  Future<Either<bool, FailureEntity>> call({
    required String name,
    required String filePath,
    required Mood mood,
    required List<String> tags,
  }) {
    final audioRecording = AudioRecording(
      id: UuidUtil.getRandomUuid(),
      name: name,
      filePath: filePath,
      mood: mood,
      tags: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return _audioRecordingRepository.saveAudioRecording(audioRecording);
  }
}
