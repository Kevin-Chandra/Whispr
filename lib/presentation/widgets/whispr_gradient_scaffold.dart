import 'package:flutter/material.dart';

class WhisprGradientScaffold extends StatelessWidget {
  const WhisprGradientScaffold({super.key, required this.gradient, this.body});

  final Gradient gradient;
  final Widget? body;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: body,
      ),
    );
  }
}
