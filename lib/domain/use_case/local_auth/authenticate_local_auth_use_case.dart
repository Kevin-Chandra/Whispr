import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/local_authentication_repository.dart';

@injectable
class AuthenticateLocalAuthUseCase {
  ///
  /// A use case to authenticate user using biometric.
  ///
  AuthenticateLocalAuthUseCase(this._localAuthenticationRepository);

  final LocalAuthenticationRepository _localAuthenticationRepository;

  Future<Either<bool, FailureEntity>> call() {
    return _localAuthenticationRepository.authenticate();
  }
}
