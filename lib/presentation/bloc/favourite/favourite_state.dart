part of 'favourite_cubit.dart';

sealed class FavouriteState extends Equatable {
  const FavouriteState();

  @override
  List<Object> get props => [];
}

final class FavouriteLoadingState extends FavouriteState {}

final class FavouriteDeleteSuccessState extends FavouriteState {}

final class FavouriteAddedSuccessState extends FavouriteState {}

final class FavouriteLoadedState extends FavouriteState {
  const FavouriteLoadedState(this.audioRecordings);

  final Map<DateTime, List<AudioRecording>> audioRecordings;

  @override
  List<Object> get props => [audioRecordings];
}

final class FavouriteErrorState extends FavouriteState {
  const FavouriteErrorState(this.error);

  final FailureEntity error;

  @override
  List<Object> get props => [error];
}
