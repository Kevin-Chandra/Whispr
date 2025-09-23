import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_icon_button.dart';

class AudioPlayerErrorBody extends StatelessWidget {
  const AudioPlayerErrorBody({
    super.key,
    required this.errorTitle,
    required this.errorMessage,
    this.onRetryClicked,
    this.icon,
  });

  final IconData? icon;
  final String errorTitle;
  final String errorMessage;
  final VoidCallback? onRetryClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          icon != null
              ? Icon(icon, size: 36, color: WhisprColors.crayola)
              : SizedBox(),
          Text(
            errorTitle,
            style: WhisprTextStyles.bodyL,
          ),
          Text(
            errorMessage,
            style: WhisprTextStyles.bodyS,
          ),
          SizedBox(
            height: onRetryClicked != null ? 8 : 0,
          ),
          onRetryClicked != null
              ? WhisprIconButton(
                  icon: Icons.refresh_rounded,
                  onClick: onRetryClicked!,
                  buttonStyle: WhisprIconButtonStyle.solid,
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
