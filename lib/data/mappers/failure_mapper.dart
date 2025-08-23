import 'package:whispr/data/models/service_failure_model.dart';
import 'package:whispr/domain/entities/failure_entity.dart';

extension ServiceFailureModelMapper on ServiceFailureModel {
  FailureEntity mapToDomain() => FailureEntity(
        error: message ?? 'Error!',
        errorDescription: '',
        exception: serviceException,
      );
}
