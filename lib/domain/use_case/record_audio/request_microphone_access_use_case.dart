import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/record_audio_repository.dart';

@singleton
class RequestMicrophoneAccessUseCase {
  RequestMicrophoneAccessUseCase(this._recordAudioRepository);

  final RecordAudioRepository _recordAudioRepository;

  Future<Either<void, FailureEntity>> call() async {
    return await _recordAudioRepository.requestMicrophonePermission();
  }
}
