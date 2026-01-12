import 'package:flutter/material.dart';
import 'package:whispr/domain/entities/mood.dart';
import 'package:whispr/domain/entities/recording_tag.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/center_fill_or_scroll_layout.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_sizes.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_gradient_button.dart';
import 'package:whispr/presentation/widgets/whispr_mood_picker.dart';
import 'package:whispr/presentation/widgets/whispr_recording_tag_autocomplete.dart';
import 'package:whispr/presentation/widgets/whispr_text_field.dart';
import 'package:whispr/util/date_time_util.dart';
import 'package:whispr/util/extensions.dart';

class SaveAudioRecordingBody extends StatelessWidget {
  const SaveAudioRecordingBody({
    super.key,
    required this.waveformWidget,
    required this.titleFormKey,
    required this.titleController,
    required this.onCancelClick,
    required this.onSaveClick,
    required this.onMoodSelected,
    required this.onRecordingTagChanged,
    this.selectedMood,
    this.selectedRecordingTags,
    this.isEdit = false,
    this.createdAt,
  });

  final bool isEdit;
  final Widget waveformWidget;
  final GlobalKey<FormState> titleFormKey;
  final TextEditingController titleController;
  final VoidCallback onCancelClick;
  final VoidCallback? onSaveClick;
  final Function(Mood) onMoodSelected;
  final Function(List<RecordingTag>) onRecordingTagChanged;
  final Mood? selectedMood;
  final List<RecordingTag>? selectedRecordingTags;
  final DateTime? createdAt;

  @override
  Widget build(BuildContext context) {
    const gap = 16.0;
    return CenterFillOrScrollLayout(
      layoutPlacement: LayoutPlacement.fill,
      padding: const EdgeInsets.symmetric(horizontal: 16.0) +
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      children: [
        isEdit
            ? Form(
                key: titleFormKey,
                child: WhisprTextField(
                  controller: titleController,
                  textAlign: TextAlign.center,
                  textStyle: WhisprTextStyles.heading2
                      .copyWith(color: WhisprColors.spanishViolet),
                  whisprTextFieldStyle: WhisprTextFieldStyle.underlined,
                  validator: (value) {
                    if (value.isNullOrEmpty) {
                      return context.strings.titleEmptyErrorMessage;
                    }
                    return null;
                  },
                ),
              )
            : Text(
                context.strings.whatWouldYouLikeToNameThis,
                style: WhisprTextStyles.heading3
                    .copyWith(color: WhisprColors.spanishViolet),
                textAlign: TextAlign.center,
              ),
        isEdit
            ? Text(createdAt!.createdAtFormattedTime,
                style: WhisprTextStyles.subtitle2
                    .copyWith(color: WhisprColors.vistaBlue))
            : SizedBox(),
        const SizedBox(height: gap),
        waveformWidget,
        const SizedBox(height: gap),
        Column(
          children: [
            isEdit
                ? SizedBox()
                : Form(
                    key: titleFormKey,
                    child: WhisprTextField(
                      maxLines: 1,
                      controller: titleController,
                      title: context.strings.whatIsThisAbout,
                      whisprTextFieldStyle: WhisprTextFieldStyle.outlined,
                      validator: (value) {
                        if (value.isNullOrEmpty) {
                          return context.strings.titleEmptyErrorMessage;
                        }
                        return null;
                      },
                    ),
                  ),
            const SizedBox(height: 16),
            WhisprRecordingTagAutocomplete(
              onSelectedTagChanged: onRecordingTagChanged,
              selectedTags: selectedRecordingTags,
            ),
          ],
        ),
        const SizedBox(height: gap),
        Center(
          child: Text(
            context.strings.selectAMood,
            style: WhisprTextStyles.heading4.copyWith(
              color: WhisprColors.spanishViolet,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        WhisprMoodPicker(
          selectedMood: selectedMood,
          onMoodSelected: onMoodSelected,
        ),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: WhisprGradientButton(
                text: context.strings.cancel,
                buttonStyle: WhisprGradientButtonStyle.outlined,
                buttonSize: WhisprButtonSizes.medium,
                onPressed: onCancelClick,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: WhisprGradientButton(
                text: context.strings.saveEntry,
                buttonStyle: WhisprGradientButtonStyle.filled,
                buttonSize: WhisprButtonSizes.medium,
                onPressed: onSaveClick,
              ),
            )
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
