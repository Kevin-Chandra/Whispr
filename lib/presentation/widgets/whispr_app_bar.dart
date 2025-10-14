import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';

class WhisprAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WhisprAppBar({
    super.key,
    required this.title,
    this.enableBackButton = true,
    this.isDarkBackground = true,
    this.pinned = false,
  });

  final String title;
  final bool enableBackButton;
  final bool isDarkBackground;
  final bool pinned;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: false,
      titleTextStyle: WhisprTextStyles.heading4.copyWith(
        color: isDarkBackground ? Colors.white : WhisprColors.spanishViolet,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      leading: enableBackButton
          ? context.router.canNavigateBack
              ? IconButton(
                  onPressed: () {
                    context.router.maybePop();
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
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
