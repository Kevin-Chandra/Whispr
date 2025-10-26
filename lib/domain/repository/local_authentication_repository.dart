import 'package:dartz/dartz.dart';
import 'package:whispr/domain/entities/failure_entity.dart';

abstract class LocalAuthenticationRepository {
  Future<bool> isDeviceSupported();

  Future<Either<bool, FailureEntity>> authenticate();
}
