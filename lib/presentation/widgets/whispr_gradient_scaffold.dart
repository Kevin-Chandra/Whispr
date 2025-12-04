import 'package:flutter/material.dart';

class WhisprGradientScaffold extends StatelessWidget {
  const WhisprGradientScaffold({
    super.key,
    required this.gradient,
    this.appBar,
    this.body,
    this.bottomNavigationBar,
    this.resizeToAvoidBottomInset = false,
  });

  final Gradient gradient;
  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: Scaffold(
        appBar: appBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: Colors.transparent,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
