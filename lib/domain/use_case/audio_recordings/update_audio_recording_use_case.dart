import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/entities/mood.dart';
import 'package:whispr/domain/entities/recording_tag.dart';
import 'package:whispr/domain/repository/audio_recording_repository.dart';

@injectable
class UpdateAudioRecordingUseCase {
  UpdateAudioRecordingUseCase(this._audioRecordingRepository);

  final AudioRecordingRepository _audioRecordingRepository;

  Future<Either<bool, FailureEntity>> call({
    required AudioRecording currentAudioRecording,
    String? name,
    Mood? mood,
    bool? isFavourite,
    List<RecordingTag>? tags,
  }) {
    final audioRecording = currentAudioRecording.copyWith(
      name: name,
      mood: mood,
      tags: tags,
      isFavourite: isFavourite,
      updatedAt: DateTime.now(),
    );

    return _audioRecordingRepository.updateAudioRecording(audioRecording);
  }
}
