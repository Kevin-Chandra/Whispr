import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_button_sizes.dart';
import 'package:whispr/presentation/widgets/whispr_button/whispr_gradient_button.dart';
import 'package:whispr/presentation/widgets/whispr_text_field.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/date_time_util.dart';
import 'package:whispr/util/extensions.dart';

class BackupBody extends StatelessWidget {
  const BackupBody({
    super.key,
    required this.fileNameController,
    required this.firstDate,
    required this.startDateValue,
    required this.endDateValue,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
    required this.recordCountWidget,
    this.onSharePressed,
    this.onDownloadPressed,
    this.onBackupPressed,
    this.recentBackup,
  });

  final Widget recordCountWidget;
  final TextEditingController fileNameController;
  final DateTime firstDate;
  final DateTime startDateValue;
  final DateTime endDateValue;
  final Function(DateTime) onStartDateChanged;
  final Function(DateTime) onEndDateChanged;
  final VoidCallback? onBackupPressed;
  final File? recentBackup;
  final VoidCallback? onSharePressed;
  final VoidCallback? onDownloadPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(
            flex: 1,
          ),
          Icon(
            Icons.archive_rounded,
            size: 56,
            color: WhisprColors.lavenderBlue,
          ),
          SizedBox(height: 16),
          Text(
            context.strings.export,
            style: WhisprTextStyles.heading4
                .copyWith(color: WhisprColors.spanishViolet),
          ),
          SizedBox(height: 8),
          Text(
            context.strings.exportSubtitle,
            style:
                WhisprTextStyles.bodyS.copyWith(color: WhisprColors.vistaBlue),
          ),
          SizedBox(height: 24),
          BackupInputBody(
            fileNameController: fileNameController,
            firstDate: firstDate,
            startDateValue: startDateValue,
            endDateValue: endDateValue,
            onStartDateChanged: onStartDateChanged,
            onEndDateChanged: onEndDateChanged,
          ),
          recordCountWidget,
          SizedBox(height: 24),
          WhisprGradientButton(
            text: context.strings.export,
            buttonSize: WhisprButtonSizes.medium,
            onPressed: onBackupPressed,
            buttonStyle: WhisprGradientButtonStyle.filled,
            gradient:
                WhisprGradient.blueMagentaVioletInterdimensionalBlueGradient,
          ),
          SizedBox(height: 48),
          recentBackup != null
              ? RecentBackupFilePreview(
                  recentBackupFile: recentBackup!,
                  onSharePressed: onSharePressed,
                  onDownloadPressed: onDownloadPressed,
                )
              : SizedBox(),
          Spacer(
            flex: 2,
          )
        ],
      ),
    );
  }
}

class BackupInputBody extends StatelessWidget {
  const BackupInputBody({
    super.key,
    required this.fileNameController,
    required this.firstDate,
    required this.startDateValue,
    required this.endDateValue,
    required this.onStartDateChanged,
    required this.onEndDateChanged,
  });

  final TextEditingController fileNameController;
  final DateTime firstDate;
  final DateTime startDateValue;
  final DateTime endDateValue;
  final Function(DateTime) onStartDateChanged;
  final Function(DateTime) onEndDateChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BackupRowItem(
          roundedCorner: RowItemRoundedCorner.top,
          icon: Icons.date_range_rounded,
          label: context.strings.from,
          value: startDateValue.formattedDate,
          onClick: () async {
            final startDate = await _getDate(
              context,
              startDateValue,
              firstDate,
              endDateValue,
            );
            if (startDate != null) {
              onStartDateChanged(startDate);
            }
          },
        ),
        Divider(
          height: 1,
          color: WhisprColors.lavenderWeb,
        ),
        BackupRowItem(
          roundedCorner: RowItemRoundedCorner.none,
          icon: Icons.date_range_rounded,
          label: context.strings.to,
          value: endDateValue.formattedDate,
          onClick: () async {
            final endDate = await _getDate(
              context,
              endDateValue,
              startDateValue,
              DateTime.now(),
            );
            if (endDate != null) {
              onEndDateChanged(endDate);
            }
          },
        ),
        Divider(
          height: 1,
          color: WhisprColors.lavenderWeb,
        ),
        BackupRowItem(
          isRequired: true,
          roundedCorner: RowItemRoundedCorner.bottom,
          icon: Icons.save_rounded,
          label: context.strings.fileName,
          value: endDateValue.formattedDate,
          controller: fileNameController,
        ),
        SizedBox(
          height: 16,
        ),
      ],
    );
  }

  Future<DateTime?> _getDate(
    BuildContext context,
    DateTime initialDate,
    DateTime firstDate,
    DateTime lastDate,
  ) async {
    return await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }
}

class BackupRowItem extends StatelessWidget {
  const BackupRowItem({
    super.key,
    required this.roundedCorner,
    required this.label,
    required this.value,
    this.icon,
    this.onClick,
    this.controller,
    this.isRequired = false,
  });

  final bool isRequired;
  final IconData? icon;
  final String label;
  final String value;
  final VoidCallback? onClick;
  final TextEditingController? controller;
  final RowItemRoundedCorner roundedCorner;

  @override
  Widget build(BuildContext context) {
    final cornerRadius = 15.0;
    final borderRadius = switch (roundedCorner) {
      RowItemRoundedCorner.top =>
        BorderRadius.vertical(top: Radius.circular(cornerRadius)),
      RowItemRoundedCorner.bottom =>
        BorderRadius.vertical(bottom: Radius.circular(cornerRadius)),
      RowItemRoundedCorner.all => BorderRadius.circular(cornerRadius),
      RowItemRoundedCorner.none => BorderRadius.zero,
    };

    return Material(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      color: Colors.white,
      child: InkWell(
        onTap: controller == null ? onClick : null,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  spacing: 8,
                  children: [
                    if (icon != null)
                      Icon(
                        icon,
                        color: WhisprColors.spanishViolet,
                      ),
                    RichText(
                      text: TextSpan(
                        text: label,
                        style: WhisprTextStyles.bodyS
                            .copyWith(color: WhisprColors.spanishViolet),
                        children: [
                          if (isRequired)
                            TextSpan(
                              text: " *",
                              style: WhisprTextStyles.bodyS
                                  .copyWith(color: WhisprColors.crayola),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: controller == null
                    ? Text(value,
                        textAlign: TextAlign.right,
                        style: WhisprTextStyles.bodyS
                            .copyWith(color: WhisprColors.spanishViolet))
                    : WhisprTextField(
                        controller: controller,
                        suffixText: FileConstants.archiveFileExtension,
                        whisprTextFieldStyle: WhisprTextFieldStyle.skeleton,
                        textAlign: TextAlign.right,
                        textStyle: WhisprTextStyles.bodyS
                            .copyWith(color: WhisprColors.spanishViolet),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum RowItemRoundedCorner { top, bottom, all, none }

class RecentBackupFilePreview extends StatelessWidget {
  const RecentBackupFilePreview({
    super.key,
    required this.recentBackupFile,
    this.onSharePressed,
    this.onDownloadPressed,
  });

  final File recentBackupFile;
  final VoidCallback? onSharePressed;
  final VoidCallback? onDownloadPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, bottom: 4),
          child: Text(context.strings.recentBackup,
              style: WhisprTextStyles.heading4
                  .copyWith(color: WhisprColors.spanishViolet)),
        ),
        Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.folder_zip_rounded,
                  color: WhisprColors.spanishViolet,
                  size: 42,
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.basename(recentBackupFile.path),
                        style: WhisprTextStyles.bodyM.copyWith(
                            color: WhisprColors.spanishViolet,
                            fontWeight: FontWeight.bold)),
                    Text(recentBackupFile.statSync().size.formatBytes(),
                        style: WhisprTextStyles.subtitle1
                            .copyWith(color: WhisprColors.spanishViolet)),
                    Text(
                        context.strings.lastBackup(recentBackupFile
                            .statSync()
                            .modified
                            .displayTimeAgo(context: context)),
                        style: WhisprTextStyles.subtitle1
                            .copyWith(color: WhisprColors.spanishViolet)),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: onDownloadPressed,
                  icon: Icon(Icons.download_rounded),
                  color: WhisprColors.spanishViolet,
                ),
                IconButton(
                  onPressed: onSharePressed,
                  icon: Icon(Icons.share_rounded),
                  color: WhisprColors.spanishViolet,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
