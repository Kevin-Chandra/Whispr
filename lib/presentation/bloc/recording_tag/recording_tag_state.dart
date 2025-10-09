part of 'recording_tag_cubit.dart';

sealed class RecordingTagScreenState extends Equatable {
  const RecordingTagScreenState(this.availableTagOptions, this.selectedTags);

  final List<RecordingTag> availableTagOptions;
  final List<RecordingTag> selectedTags;

  @override
  List<Object> get props => [availableTagOptions, selectedTags];

  RecordingTagScreenState copyWith(
    List<RecordingTag> availableTagOptions,
    List<RecordingTag> selectedTags,
  );
}

final class RecordingTagLoadingState extends RecordingTagScreenState {
  const RecordingTagLoadingState(super.availableTagOptions, super.selectedTags);

  @override
  RecordingTagScreenState copyWith(List<RecordingTag> availableTagOptions,
          List<RecordingTag> selectedTags) =>
      RecordingTagLoadingState(availableTagOptions, selectedTags);
}

final class RecordingTagLoadedState extends RecordingTagScreenState {
  const RecordingTagLoadedState(super.availableTagOptions, super.selectedTags);

  @override
  RecordingTagScreenState copyWith(List<RecordingTag> availableTagOptions,
          List<RecordingTag> selectedTags) =>
      RecordingTagLoadedState(availableTagOptions, selectedTags);
}

final class RecordingTagErrorState extends RecordingTagScreenState {
  const RecordingTagErrorState(
      super.availableTagOptions, super.selectedTags, this.error);

  final FailureEntity error;

  @override
  RecordingTagScreenState copyWith(List<RecordingTag> availableTagOptions,
          List<RecordingTag> selectedTags) =>
      RecordingTagErrorState(availableTagOptions, selectedTags, error);

  @override
  List<Object> get props => [availableTagOptions, selectedTags, error];
}
