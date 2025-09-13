import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/data/local/audio_recorder/record_audio_service.dart';
import 'package:whispr/data/local/file_service.dart';
import 'package:whispr/data/mappers/failure_mapper.dart';
import 'package:whispr/data/models/audio_recorder_state.dart';
import 'package:whispr/domain/entities/audio_recorder_command.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/record_audio_repository.dart';
import 'package:whispr/util/constants.dart';

@Singleton(as: RecordAudioRepository)
class RecordAudioRepositoryImpl extends RecordAudioRepository {
  RecordAudioRepositoryImpl(this._recordAudioService, this._fileService);

  final RecordAudioService _recordAudioService;
  final FileService _fileService;

  @override
  void openAppSettings() => _recordAudioService.openAppPermissionSettings();

  @override
  Stream<AudioRecorderState> get audioRecorderStateStream =>
      _recordAudioService.audioRecorderStateStream;

  @override
  Future<void> sendCommand(AudioRecorderCommand command) async {
    switch (command) {
      case AudioRecorderCommand.pause:
        {
          _recordAudioService.pauseRecord();
        }
      case AudioRecorderCommand.resume:
        {
          _recordAudioService.resumeRecord();
        }
    }
  }

  @override
  Future<Either<bool, FailureEntity>> startRecording() async {
    final audioFilePath = await _fileService.createAudioPath();
    final response = await _recordAudioService.startRecord(audioFilePath);

    return response.fold((isSuccess) {
      return left(isSuccess);
    }, (fail) {
      return right(fail.mapToDomain());
    });
  }

  @override
  Future<Either<String, FailureEntity>> stopRecording() async {
    final response = await _recordAudioService.stopRecord();
    return response.fold((path) {
      return left(path);
    }, (fail) {
      return right(fail.mapToDomain());
    });
  }

  @override
  Future<Either<bool, FailureEntity>> cancelRecording() async {
    final response = await _recordAudioService.cancelRecord();
    return response.fold((success) {
      return left(success);
    }, (fail) {
      return right(fail.mapToDomain());
    });
  }

  @override
  Stream<double> getAudioRecorderAmplitudeStream() => _recordAudioService
      .getAudioRecorderAmplitude(
          Duration(milliseconds: WhisprDuration.amplitudeStreamUpdateMillis))
      .map((amplitude) => _dbToLinearRange(amplitude.current));

  @override
  Stream<Duration> getAudioRecorderTimerStream() =>
      _recordAudioService.recordingTimerStream;

  double _dbToLinearRange(double db, {double minDb = -60}) {
    final clamped = db.clamp(minDb, 0.0);
    return (clamped - minDb) / (0.0 - minDb);
  }
}
