import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:whispr/presentation/screens/backup/backup_body.dart';

class BackupSkeletonLoading extends StatelessWidget {
  const BackupSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        child: BackupBody(
      fileNameController: TextEditingController(),
      firstDate: DateTime.now(),
      startDateValue: DateTime.now(),
      endDateValue: DateTime.now(),
      onStartDateChanged: (_) {},
      onEndDateChanged: (_) {},
      recordCountWidget: SizedBox(height: 8),
    ));
  }
}
