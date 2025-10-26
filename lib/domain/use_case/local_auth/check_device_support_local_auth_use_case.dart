import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/local_authentication_repository.dart';
import 'package:whispr/domain/repository/record_audio_repository.dart';

@injectable
class CheckDeviceSupportLocalAuthUseCase {
  ///
  /// A use case to check whether current device support local biometric authentication.
  ///
  CheckDeviceSupportLocalAuthUseCase(this._localAuthenticationRepository);

  final LocalAuthenticationRepository _localAuthenticationRepository;

  Future<bool> call() {
    return _localAuthenticationRepository.isDeviceSupported();
  }
}
