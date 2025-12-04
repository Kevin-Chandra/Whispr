import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'clear_all_data_body.dart';

class ClearAllDataLoadingSkeleton extends StatelessWidget {
  const ClearAllDataLoadingSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(child: ClearAllDataBody(onDeletePressed: () {}));
  }
}
