import 'package:flutter/material.dart';

class WhisprSnackBar {
  ///
  /// Generic Whispr Snack bar that displays a [title], an optional [subtitle] and
  /// can switch between a normal state and an error state.
  ///
  const WhisprSnackBar({
    required this.title,
    this.subtitle,
    this.isError = false,
  });

  final String title;
  final String? subtitle;
  final bool isError;

  SnackBar buildSnackBar(BuildContext context) {
    return SnackBar(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      // backgroundColor: isError ? AtlasColors.sinopia : AtlasColors.oxfordBlue,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      dismissDirection: DismissDirection.down,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            isError ? Icons.info_rounded : Icons.check_rounded,
            color: Colors.white,
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  // style: AtlasTextStyle.badgeS.copyWith(color: Colors.white),
                ),
                SizedBox(
                  height: subtitle != null ? 6 : 0,
                ),
                subtitle != null
                    ? Text(
                        subtitle!,
                        // style:
                        // AtlasTextStyle.bodyS.copyWith(color: Colors.white),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(context));
  }
}
