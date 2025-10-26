import 'package:equatable/equatable.dart';

sealed class LocalAuthenticationException extends Equatable
    implements Exception {
  const LocalAuthenticationException();

  @override
  List<Object> get props => [];
}

final class BiometricsNotEnrolledException
    extends LocalAuthenticationException {}

final class NoBiometricHardwareException extends LocalAuthenticationException {}

final class TemporaryLockoutException extends LocalAuthenticationException {}

final class UserCancelledException extends LocalAuthenticationException {}

final class UnknownException extends LocalAuthenticationException {}
