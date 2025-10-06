import 'package:flutter/material.dart';

class WhisprGradientScaffold extends StatelessWidget {
  const WhisprGradientScaffold({
    super.key,
    required this.gradient,
    this.appBar,
    this.body,
    this.bottomNavigationBar,
  });

  final Gradient gradient;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: Scaffold(
        appBar: appBar,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
