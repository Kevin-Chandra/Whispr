import 'package:dartz/dartz.dart';
import 'package:whispr/domain/entities/failure_entity.dart';

abstract class RecordAudioRepository {
  Future<Either<void, FailureEntity>> requestMicrophonePermission();

  void openAppSettings();
}
