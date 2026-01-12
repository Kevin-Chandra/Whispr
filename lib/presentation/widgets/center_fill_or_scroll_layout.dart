import 'package:flutter/material.dart';

class CenterFillOrScrollLayout extends StatelessWidget {
  const CenterFillOrScrollLayout({
    super.key,
    required this.layoutPlacement,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.scrollPhysics = const BouncingScrollPhysics(),
    this.padding,
  });

  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? scrollPhysics;
  final LayoutPlacement layoutPlacement;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          padding: padding,
          physics: scrollPhysics,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: switch (layoutPlacement) {
              LayoutPlacement.center => IntrinsicHeight(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: crossAxisAlignment,
                      mainAxisSize: MainAxisSize.min,
                      children: children,
                    ),
                  ),
                ),
              LayoutPlacement.fill => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: crossAxisAlignment,
                  mainAxisSize: MainAxisSize.max,
                  children: children,
                )
            },
          ),
        );
      },
    );
  }
}

enum LayoutPlacement { center, fill }
