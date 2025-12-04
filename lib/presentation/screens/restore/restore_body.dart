import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_sizes.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_gradient_button.dart';
import 'package:whispr/util/extensions.dart';

class RestoreBody extends StatelessWidget {
  const RestoreBody({
    super.key,
    required this.onRemoveFilePressed,
    this.onSelectFilePressed,
    this.onRestorePressed,
    this.file,
  });

  final File? file;
  final VoidCallback? onSelectFilePressed;
  final VoidCallback onRemoveFilePressed;
  final VoidCallback? onRestorePressed;

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
              Icons.restore_rounded,
              size: 56,
              color: WhisprColors.lavenderBlue,
            ),
            SizedBox(height: 16),
            Text(
              context.strings.import,
              style: WhisprTextStyles.heading4
                  .copyWith(color: WhisprColors.spanishViolet),
            ),
            SizedBox(height: 8),
            Text(
              context.strings.importSubtitle,
              style: WhisprTextStyles.bodyS
                  .copyWith(color: WhisprColors.vistaBlue),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            FilePreview(
              file: file,
              onRemovePressed: onRemoveFilePressed,
              onPressed: file == null ? onSelectFilePressed : null,
            ),
            SizedBox(height: 24),
            WhisprGradientButton(
              text: context.strings.import,
              buttonSize: WhisprButtonSizes.medium,
              onPressed: onRestorePressed,
              buttonStyle: WhisprGradientButtonStyle.filled,
              gradient:
                  WhisprGradient.blueMagentaVioletInterdimensionalBlueGradient,
            ),
            Spacer(
              flex: 2,
            )
          ],
        ),
      ),
    );
  }
}

class FilePreview extends StatelessWidget {
  const FilePreview({
    super.key,
    required this.onRemovePressed,
    this.onPressed,
    this.file,
  });

  final File? file;
  final VoidCallback? onPressed;
  final VoidCallback onRemovePressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                file == null ? Icons.add_rounded : Icons.folder_zip_rounded,
                color: WhisprColors.spanishViolet,
                size: 42,
              ),
              SizedBox(width: 8),
              file == null
                  ? Text(
                      context.strings.selectAFile,
                      style: WhisprTextStyles.bodyL.copyWith(
                          color: WhisprColors.spanishViolet,
                          fontWeight: FontWeight.bold),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.basename(file!.path),
                            style: WhisprTextStyles.bodyM.copyWith(
                                color: WhisprColors.spanishViolet,
                                fontWeight: FontWeight.bold)),
                        Text(file!.statSync().size.formatBytes(),
                            style: WhisprTextStyles.subtitle1
                                .copyWith(color: WhisprColors.spanishViolet))
                      ],
                    ),
              Spacer(),
              file != null
                  ? IconButton(
                      onPressed: onRemovePressed,
                      icon: Icon(Icons.close_rounded),
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
