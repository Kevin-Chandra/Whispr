import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_icon_button.dart';
import 'package:whispr/util/extensions.dart';

class RecordAudioControls extends StatefulWidget {
  const RecordAudioControls({
    super.key,
    required this.onSaveClick,
    required this.onPauseClick,
    required this.onResumeClick,
    required this.onCancelClick,
    required this.isRecording,
  });

  final VoidCallback onSaveClick;
  final VoidCallback onPauseClick;
  final VoidCallback onResumeClick;
  final VoidCallback onCancelClick;
  final bool isRecording;

  @override
  State<RecordAudioControls> createState() => _RecordAudioControlsState();
}

class _RecordAudioControlsState extends State<RecordAudioControls> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        widget.isRecording
            ? _elevatedButtonAndText(
                onClick: widget.onPauseClick,
                icon: Icons.pause_rounded,
                buttonSize: ButtonSize.xLarge,
                text: context.strings.pause,
              )
            : _elevatedButtonAndText(
                onClick: widget.onResumeClick,
                icon: Icons.play_arrow_rounded,
                buttonSize: ButtonSize.xLarge,
                text: context.strings.resume,
              ),
        _elevatedButtonAndText(
          onClick: widget.onSaveClick,
          icon: Icons.check_rounded,
          buttonSize: ButtonSize.xxLarge,
          text: context.strings.save,
        ),
        _elevatedButtonAndText(
          onClick: widget.onCancelClick,
          icon: Icons.close_rounded,
          buttonSize: ButtonSize.xLarge,
          text: context.strings.cancel,
        ),
      ],
    );
  }

  Widget _elevatedButtonAndText({
    required VoidCallback onClick,
    required IconData icon,
    required ButtonSize buttonSize,
    required String text,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        WhisprIconButton(
          onClick: onClick,
          icon: icon,
          buttonSize: buttonSize,
          buttonStyle: WhisprIconButtonStyle.solid,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          text,
          style: WhisprTextStyles.heading5
              .copyWith(color: WhisprColors.cornflowerBlue),
        ),
      ],
    );
  }
}
