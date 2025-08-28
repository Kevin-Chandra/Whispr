import 'package:equatable/equatable.dart';

sealed class AudioPlayerException extends Equatable implements Exception {
  const AudioPlayerException();

  @override
  List<Object> get props => [];
}

final class AudioFileNotFoundException extends AudioPlayerException {}
