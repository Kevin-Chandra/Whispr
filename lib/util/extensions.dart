import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/lang/generated/whispr_localizations.dart';

extension ContextExtensions on BuildContext {
  /// To access localised strings.
  /// Usage: [context.strings.yourString]
  WhisprLocalizations get strings => WhisprLocalizations.of(this)!;
}

extension CubitExtension<T> on Cubit<T> {
  ///
  /// To prevent the [StateError] being thrown when Cubits are emitting states after they were closed. (User Navigated away)
  ///
  void safeEmit(T state) {
    if (!isClosed) {
      emit(state);
    }
  }
}

extension NullableStringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  bool safeParseBool({required bool defaultValue}) {
    try {
      return bool.parse(this!, caseSensitive: false);
    } catch (e) {
      return defaultValue;
    }
  }
}

extension StringExtension on String {
  bool isDigit() {
    return RegExp(r'^\d+$').hasMatch(this);
  }

  bool equalsIgnoreCase(String other) {
    return toLowerCase() == other.toLowerCase();
  }
}

extension IterableExtension<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E element) getFirst) {
    return where(getFirst).firstOrNull;
  }
}
