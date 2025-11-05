import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/di/di_config.dart';
import 'package:whispr/domain/entities/failure_entity.dart';
import 'package:whispr/domain/entities/recording_tag.dart';
import 'package:whispr/domain/use_case/recording_tags/get_all_recording_tags_use_case.dart';
import 'package:whispr/domain/use_case/recording_tags/save_recording_tag_use_case.dart';
import 'package:whispr/util/extensions.dart';

part 'recording_tag_state.dart';

class RecordingTagCubit extends Cubit<RecordingTagScreenState> {
  RecordingTagCubit() : super(RecordingTagLoadingState([], [])) {
    getRecordingTags();
  }

  final List<RecordingTag> _availableTagOptions = List.empty(growable: true);
  final Set<RecordingTag> _selectedTag = {};

  void getRecordingTags() async {
    safeEmit(
        RecordingTagLoadingState(_availableTagOptions, _selectedTag.toList()));

    final response = await di.get<GetAllRecordingTagsUseCase>().call();
    return response.fold((tags) {
      _availableTagOptions.clear();
      _availableTagOptions.addAll(tags);
      safeEmit(
          RecordingTagLoadedState(_availableTagOptions, _selectedTag.toList()));
    }, (error) {
      safeEmit(RecordingTagErrorState(
        _availableTagOptions,
        _selectedTag.toList(),
        error,
      ));
    });
  }

  void createNewTag(String label) async {
    final response = await di.get<SaveRecordingTagUseCase>().call(label);
    return response.fold((newTag) {
      getRecordingTags();
      selectTag(newTag);
    }, (error) {
      safeEmit(RecordingTagErrorState(
        _availableTagOptions,
        _selectedTag.toList(),
        error,
      ));
    });
  }

  void selectTag(RecordingTag tag) {
    safeEmit(
        RecordingTagLoadingState(_availableTagOptions, _selectedTag.toList()));

    _selectedTag.add(tag);
    safeEmit(
        RecordingTagLoadedState(_availableTagOptions, _selectedTag.toList()));
  }

  void unselectTag(RecordingTag tag) {
    safeEmit(
        RecordingTagLoadingState(_availableTagOptions, _selectedTag.toList()));

    _selectedTag.remove(tag);
    safeEmit(
        RecordingTagLoadedState(_availableTagOptions, _selectedTag.toList()));
  }

  void setSelectedTags(List<RecordingTag> tags) {
    _selectedTag.clear();
    _selectedTag.addAll(tags);
    safeEmit(
        RecordingTagLoadedState(_availableTagOptions, _selectedTag.toList()));
  }
}
