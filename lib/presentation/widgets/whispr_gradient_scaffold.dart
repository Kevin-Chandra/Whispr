import 'package:flutter/material.dart';

class WhisprGradientScaffold extends StatelessWidget {
  const WhisprGradientScaffold({
    super.key,
    required this.gradient,
    this.body,
    this.bottomNavigationBar,
  });

  final Gradient gradient;
  final Widget? body;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
