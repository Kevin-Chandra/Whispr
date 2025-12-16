import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:whispr/presentation/screens/journal/journal_header.dart';

class JournalHeaderSkeletonLoading extends StatelessWidget {
  const JournalHeaderSkeletonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: JournalHeader(
        minDate: DateTime.now(),
        markedDates: {},
        onDateChange: (_) {},
      ),
    );
  }
}
