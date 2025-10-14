import 'package:flutter/material.dart';
import 'package:whispr/domain/entities/mood.dart';
import 'package:whispr/domain/entities/recording_tag.dart';
import 'package:whispr/presentation/screens/save_audio_recording/recording_tag_autocomplete.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_sizes.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_gradient_button.dart';
import 'package:whispr/presentation/widgets/whispr_mood_picker.dart';
import 'package:whispr/presentation/widgets/whispr_text_field.dart';
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
  });

  final Widget waveformWidget;
  final GlobalKey<FormState> titleFormKey;
  final TextEditingController titleController;
  final VoidCallback onCancelClick;
  final VoidCallback? onSaveClick;
  final Function(Mood) onMoodSelected;
  final Function(List<RecordingTag>) onRecordingTagChanged;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: true,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 40),
            child: Column(
              spacing: 8,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  context.strings.whatWouldYouLikeToNameThis,
                  style: WhisprTextStyles.heading3
                      .copyWith(color: WhisprColors.spanishViolet),
                  textAlign: TextAlign.center,
                ),
                const Expanded(flex: 1, child: SizedBox()),
                waveformWidget,
                const Expanded(flex: 1, child: SizedBox()),
                Form(
                  key: titleFormKey,
                  child: WhisprTextField(
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
                RecordingTagAutocomplete(
                    onSelectedTagChanged: onRecordingTagChanged),
                const Expanded(flex: 1, child: SizedBox()),
                Text(
                  context.strings.selectAMood,
                  style: WhisprTextStyles.heading4.copyWith(
                    color: WhisprColors.spanishViolet,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                WhisprMoodPicker(
                  onMoodSelected: onMoodSelected,
                ),
                const Expanded(flex: 1, child: SizedBox()),
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
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
