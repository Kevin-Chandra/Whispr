import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/widgets/whispr_dot_indicator.dart';

class WhisprBottomNavigationBar extends StatelessWidget {
  const WhisprBottomNavigationBar({
    super.key,
    required this.controller,
  });

  final TabController controller;

  @override
  Widget build(BuildContext context) {
    final navDestinations = [
      Tab(
        icon: const Icon(Icons.mic),
      ),
      Tab(
        icon: const Icon(Icons.favorite),
      ),
      Tab(
        icon: const Icon(Icons.book),
      ),
      Tab(
        icon: const Icon(Icons.settings),
      ),
    ];
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(44),
          boxShadow: const [
            // soft outer shadow
            BoxShadow(
              blurRadius: 16,
              spreadRadius: 0,
              offset: Offset(0, 10),
              color: Colors.black12, // 10% black
            ),
          ],
        ),
        child: TabBar(
          tabs: navDestinations,
          controller: controller,
          automaticIndicatorColorAdjustment: false,
          indicatorPadding: EdgeInsets.zero,
          splashBorderRadius: BorderRadius.circular(8),
          indicator: const WhisprDotIndicator(
            color: WhisprColors.vistaBlue,
          ),
        ),
      ),
    );
  }
}
