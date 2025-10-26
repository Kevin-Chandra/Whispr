import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/data/local/local_auth/local_auth.dart';
import 'package:whispr/data/mappers/failure_mapper.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/repository/local_authentication_repository.dart';

@Injectable(as: LocalAuthenticationRepository)
class LocalAuthenticationRepositoryImpl
    implements LocalAuthenticationRepository {
  const LocalAuthenticationRepositoryImpl(this.localAuthentication);

  final LocalAuth localAuthentication;

  @override
  Future<Either<bool, FailureEntity>> authenticate() async {
    final response = await localAuthentication.authenticate();
    return response.fold(
      (success) => left(success),
      (failure) => right(failure.mapToDomain()),
    );
  }

  @override
  Future<bool> isDeviceSupported() async {
    return await localAuthentication.checkDeviceIsSupported();
  }
}
