import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:whispr/data/models/service_failure_model.dart';

@injectable
class RecordAudioService {
  Future<Either<void, ServiceFailureModel>> init() async {
    return Right(ServiceFailureModel(message: "Test", serviceException: null));
  }
}
