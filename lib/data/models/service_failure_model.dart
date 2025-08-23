class ServiceFailureModel {
  ServiceFailureModel({
    required this.message,
    required this.serviceException,
  });

  final String? message;
  final Exception? serviceException;

  factory ServiceFailureModel.empty({Exception? serviceException}) =>
      ServiceFailureModel(
        message: null,
        serviceException: serviceException,
      );
}
