part of 'audio_player_cubit.dart';

sealed class AudioPlayerScreenState extends Equatable {
  const AudioPlayerScreenState(this.state);

  final AudioPlayerState state;

  @override
  List<Object> get props => [state];

  AudioPlayerScreenState copyWith(AudioPlayerState state);
}

final class AudioPlayerInitialState extends AudioPlayerScreenState {
  const AudioPlayerInitialState(super.state);

  @override
  AudioPlayerScreenState copyWith(AudioPlayerState state) =>
      AudioPlayerInitialState(state);
}

final class AudioPlayerLoadingState extends AudioPlayerScreenState {
  const AudioPlayerLoadingState(super.state);

  @override
  AudioPlayerScreenState copyWith(AudioPlayerState state) =>
      AudioPlayerLoadingState(state);
}

final class AudioPlayerLoadedState extends AudioPlayerScreenState {
  const AudioPlayerLoadedState(
    super.state, {
    required this.controller,
    required this.waveform,
  });

  final PlayerController controller;
  final List<double> waveform;

  @override
  List<Object> get props => super.props..addAll([waveform, controller]);

  @override
  AudioPlayerScreenState copyWith(AudioPlayerState state) =>
      AudioPlayerLoadedState(
        state,
        controller: controller,
        waveform: waveform,
      );
}

final class AudioPlayerScreenError extends AudioPlayerScreenState {
  const AudioPlayerScreenError(
    super.state,
    this.error,
  );

  final FailureEntity error;

  @override
  List<Object> get props => [error];

  @override
  AudioPlayerScreenState copyWith(AudioPlayerState state) =>
      AudioPlayerScreenError(state, error);
}
