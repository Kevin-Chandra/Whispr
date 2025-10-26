import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
import 'package:whispr/data/models/service_failure_model.dart';

import 'local_authentication_exception.dart';

@injectable
class LocalAuth {
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> checkDeviceIsSupported() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    return canAuthenticateWithBiometrics || await auth.isDeviceSupported();
  }

  Future<Either<bool, ServiceFailureModel>> authenticate() async {
    try {
      final response = await auth.authenticate(
        localizedReason:
            'Let’s keep your recordings private — go ahead and verify with your fingerprint or face.',
      );

      return left(response);
    } on LocalAuthException catch (e) {
      final exception = switch (e.code) {
        LocalAuthExceptionCode.noCredentialsSet =>
          BiometricsNotEnrolledException(),
        LocalAuthExceptionCode.noBiometricsEnrolled =>
          BiometricsNotEnrolledException(),
        LocalAuthExceptionCode.noBiometricHardware =>
          NoBiometricHardwareException(),
        LocalAuthExceptionCode.biometricHardwareTemporarilyUnavailable =>
          NoBiometricHardwareException(),
        LocalAuthExceptionCode.userCanceled => UserCancelledException(),
        LocalAuthExceptionCode.temporaryLockout => TemporaryLockoutException(),
        LocalAuthExceptionCode.biometricLockout => TemporaryLockoutException(),
        LocalAuthExceptionCode.userRequestedFallback =>
          TemporaryLockoutException(),
        _ => UnknownException()
      };
      return right(ServiceFailureModel(
          serviceException: exception, message: e.description));
    } on Exception catch (e) {
      return right(ServiceFailureModel(
          serviceException: UnknownException(), message: e.toString()));
    }
  }
}
