import 'package:flutter/material.dart';

@immutable
class FailureEntity {
  const FailureEntity({
    required this.error,
    this.errorDescription,
    this.exception,
  });

  final String error;
  final String? errorDescription;
  final Exception? exception;

  factory FailureEntity.empty() => FailureEntity(error: 'Unknown error!');
}
