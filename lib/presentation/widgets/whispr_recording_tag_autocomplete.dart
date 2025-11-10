import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whispr/domain/entities/recording_tag.dart';
import 'package:whispr/presentation/bloc/recording_tag/recording_tag_cubit.dart';
import 'package:whispr/presentation/widgets/whispr_chips_autocomplete.dart';
import 'package:whispr/util/extensions.dart';

class WhisprRecordingTagAutocomplete extends StatefulWidget {
  const WhisprRecordingTagAutocomplete({
    super.key,
    required this.onSelectedTagChanged,
    this.selectedTags,
  });

  final List<RecordingTag>? selectedTags;
  final Function(List<RecordingTag>) onSelectedTagChanged;

  @override
  State<WhisprRecordingTagAutocomplete> createState() =>
      _WhisprRecordingTagAutocompleteState();
}

class _WhisprRecordingTagAutocompleteState
    extends State<WhisprRecordingTagAutocomplete> {
  late final RecordingTagCubit _recordingTagCubit;

  @override
  void initState() {
    super.initState();
    _recordingTagCubit = context.read<RecordingTagCubit>();
    if (widget.selectedTags != null && widget.selectedTags!.isNotEmpty) {
      _recordingTagCubit.setSelectedTags(widget.selectedTags!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecordingTagCubit, RecordingTagScreenState>(
      listener: (ctx, state) {
        if (state is RecordingTagLoadedState) {
          widget.onSelectedTagChanged(state.selectedTags);
          return;
        }
      },
      builder: (context, state) {
        String? errorMessage;

        final isLoading = state is RecordingTagLoadingState;
        final errorState = state is RecordingTagErrorState;

        if (errorState) {
          errorMessage = state.error.error;
        }

        return WhisprChipsAutocomplete(
          title: context.strings.tags,
          placeholder: context.strings.showAllTagOptionsHint,
          availableOptions: state.availableTagOptions,
          selectedOptions: state.selectedTags,
          onSelected: _recordingTagCubit.selectTag,
          displayText: (tag) => tag.label,
          optionValue: (tag) => tag.label,
          onDeleted: _recordingTagCubit.unselectTag,
          onCreateNewChip: _recordingTagCubit.createNewTag,
          defaultPlaceholderValue: RecordingTag.placeholder(),
          createNewDisplayText: context.strings.createNewTag,
          errorMessage: errorMessage,
          isLoading: isLoading,
        );
      },
    );
  }
}
