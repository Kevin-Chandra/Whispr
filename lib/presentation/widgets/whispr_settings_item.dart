import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';

class WhisprSettingsItem extends StatelessWidget {
  const WhisprSettingsItem({
    super.key,
    required this.label,
    required this.onClick,
    required this.style,
    this.value,
    this.onToggle,
  });

  final String label;
  final VoidCallback? onClick;
  final WhisprSettingsItemStyle style;
  final bool? value;
  final Function(bool)? onToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shadowColor: WhisprColors.spanishViolet.withValues(alpha: 0.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                height: 40,
                child: Text(
                  label,
                  style: WhisprTextStyles.bodyM.copyWith(
                      color: WhisprColors.spanishViolet,
                      fontWeight: FontWeight.bold),
                ),
              ),
              switch (style) {
                WhisprSettingsItemStyle.toggleable =>
                  Switch(value: value == true, onChanged: onToggle),
                WhisprSettingsItemStyle.clickable =>
                  Icon(Icons.chevron_right_rounded),
              }
            ],
          ),
        ),
      ),
    );
  }
}

enum WhisprSettingsItemStyle {
  toggleable,
  clickable,
}
