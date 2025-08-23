import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';

class WhisprAppBar extends StatelessWidget {
  const WhisprAppBar({
    super.key,
    required this.title,
    this.enableBackButton = true,
    this.isDarkBackground = true,
  });

  final String title;
  final bool enableBackButton;
  final bool isDarkBackground;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(title),
      titleTextStyle: TextStyle(
        color: isDarkBackground ? Colors.white : WhisprColors.spanishViolet,
        fontSize: 24,
      ),
      leading: enableBackButton
          ? context.router.canNavigateBack
              ? IconButton(
                  onPressed: () {
                    context.router.pop();
                  },
                  icon: Icon(
                    Icons.chevron_left_rounded,
                    color: isDarkBackground
                        ? Colors.white
                        : WhisprColors.spanishViolet,
                  ))
              : null
          : null,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}
