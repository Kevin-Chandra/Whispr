part of 'audio_player_cubit.dart';

sealed class AudioPlayerScreenState extends Equatable {
  const AudioPlayerScreenState(
    this.playerState,
    this.playerPosition,
    this.totalDuration,
  );

  final AudioPlayerState playerState;
  final Duration playerPosition;
  final Duration totalDuration;

  @override
  List<Object> get props => [playerState, playerPosition, totalDuration];
}

final class AudioPlayerScreenInitial extends AudioPlayerScreenState {
  const AudioPlayerScreenInitial(
    super.playerState,
    super.playerPosition,
    super.totalDuration,
  );
}

final class AudioPlayerScreenError extends AudioPlayerScreenState {
  const AudioPlayerScreenError(
    super.playerState,
    super.playerPosition,
    super.totalDuration,
    this.error,
  );

  final FailureEntity error;

  @override
  List<Object> get props => super.props..add(error);
}
