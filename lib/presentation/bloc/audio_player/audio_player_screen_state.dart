part of 'audio_player_cubit.dart';

sealed class AudioPlayerScreenState extends Equatable {
  const AudioPlayerScreenState(this.state, this.currentPlayingFile);

  final AudioPlayerState state;
  final String? currentPlayingFile;

  @override
  List<Object?> get props => [state, currentPlayingFile];

  AudioPlayerScreenState copyWith(
      AudioPlayerState state, String? currentPlayingFile);
}

final class AudioPlayerInitialState extends AudioPlayerScreenState {
  const AudioPlayerInitialState(super.state, super.currentPlayingFile);

  @override
  AudioPlayerScreenState copyWith(
          AudioPlayerState state, String? currentPlayingFile) =>
      AudioPlayerInitialState(state, currentPlayingFile);
}

final class AudioPlayerLoadingState extends AudioPlayerScreenState {
  const AudioPlayerLoadingState(super.state, super.currentPlayingFile);

  @override
  AudioPlayerScreenState copyWith(
          AudioPlayerState state, String? currentPlayingFile) =>
      AudioPlayerLoadingState(state, currentPlayingFile);
}

final class AudioPlayerLoadedState extends AudioPlayerScreenState {
  const AudioPlayerLoadedState(
    super.state,
    super.currentPlayingFile, {
    required this.controller,
    required this.waveform,
  });

  final PlayerController controller;
  final List<double> waveform;

  @override
  List<Object?> get props => [...super.props, waveform];

  @override
  AudioPlayerScreenState copyWith(
          AudioPlayerState state, String? currentPlayingFile) =>
      AudioPlayerLoadedState(
        state,
        currentPlayingFile,
        controller: controller,
        waveform: waveform,
      );
}

final class AudioPlayerScreenError extends AudioPlayerScreenState {
  const AudioPlayerScreenError(
    super.state,
    super.currentPlayingFile,
    this.error,
  );

  final FailureEntity error;

  @override
  List<Object?> get props => [...super.props, error];

  @override
  AudioPlayerScreenState copyWith(
          AudioPlayerState state, String? currentPlayingFile) =>
      AudioPlayerScreenError(state, currentPlayingFile, error);
}
