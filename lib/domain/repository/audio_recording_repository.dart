import 'package:dartz/dartz.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/domain/entities/failure_entity.dart';

abstract class AudioRecordingRepository {
  Future<Either<bool, FailureEntity>> saveAudioRecording(
      AudioRecording audioRecording);

  Future<Either<bool, FailureEntity>> deleteAudioRecording(String id);

  Stream<List<AudioRecording>> getAllRecordings();
}
