import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_sizes.dart';
import 'package:whispr/util/extensions.dart';

class JournalEmptyBody extends StatelessWidget {
  const JournalEmptyBody({
    super.key,
    required this.onAddNewRecording,
  });

  final VoidCallback onAddNewRecording;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            context.strings.journalEmptyPlaceholder,
            style: WhisprTextStyles.heading5
                .copyWith(color: WhisprColors.spanishViolet),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          WhisprButton(
            text: context.strings.addNewRecording,
            buttonStyle: WhisprButtonStyle.filled,
            buttonSize: WhisprButtonSizes.small,
            icon: Icons.add_rounded,
            onPressed: onAddNewRecording,
          )
        ],
      ),
    );
  }
}
