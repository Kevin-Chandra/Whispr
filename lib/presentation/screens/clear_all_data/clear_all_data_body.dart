import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_sizes.dart';
import 'package:whispr/presentation/widgets/whispr_text_field.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/extensions.dart';

class ClearAllDataBody extends StatefulWidget {
  const ClearAllDataBody({super.key, required this.onDeletePressed});

  final VoidCallback onDeletePressed;

  @override
  State<ClearAllDataBody> createState() => _ClearAllDataBodyState();
}

class _ClearAllDataBodyState extends State<ClearAllDataBody> {
  final TextEditingController controller = TextEditingController();
  bool isDeleteButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    controller.addListener(controllerListener);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(
              flex: 1,
            ),
            Icon(
              Icons.delete_forever_rounded,
              size: 56,
              color: WhisprColors.crayola,
            ),
            SizedBox(height: 16),
            Text(
              context.strings.deleteForever,
              style: WhisprTextStyles.heading4
                  .copyWith(color: WhisprColors.spanishViolet),
            ),
            SizedBox(height: 8),
            Text(
              context.strings.clearAllDataSubtitle,
              style: WhisprTextStyles.bodyS
                  .copyWith(color: WhisprColors.vistaBlue),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            WhisprTextField(
              title: context.strings
                  .typeDeleteToConfirm(SettingsConstants.deleteKeyword),
              hint: SettingsConstants.deleteKeyword,
              whisprTextFieldStyle: WhisprTextFieldStyle.outlined,
              controller: controller,
            ),
            SizedBox(height: 24),
            WhisprButton(
              text: context.strings.deleteForever,
              buttonSize: WhisprButtonSizes.medium,
              onPressed: isDeleteButtonEnabled ? widget.onDeletePressed : null,
              buttonStyle: WhisprButtonStyle.negativeFilled,
            ),
            Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.removeListener(controllerListener);
    controller.dispose();
    super.dispose();
  }

  void controllerListener() {
    setState(() {
      isDeleteButtonEnabled =
          controller.text.equalsIgnoreCase(SettingsConstants.deleteKeyword);
    });
  }
}
