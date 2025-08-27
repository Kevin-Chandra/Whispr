import 'package:dartz/dartz.dart';
import 'package:whispr/data/models/audio_recorder_state.dart';
import 'package:whispr/domain/entities/audio_recorder_command.dart';
import 'package:whispr/domain/entities/failure_entity.dart';

abstract class RecordAudioRepository {
  Stream<AudioRecorderState> get audioRecorderStateStream;

  void openAppSettings();

  Future<Either<bool, FailureEntity>> startRecording();

  Future<Either<String, FailureEntity>> stopRecording();

  Future<void> sendCommand(AudioRecorderCommand command);
}
