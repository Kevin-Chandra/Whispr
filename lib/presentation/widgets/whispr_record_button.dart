import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_radial_visualizer.dart';

class WhisprRecordButton extends StatelessWidget {
  const WhisprRecordButton({
    super.key,
    required this.onClick,
    this.amplitudeLevel,
  });

  final VoidCallback onClick;
  final double? amplitudeLevel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: WhisprGradient.purpleShadeGradient,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 36,
                offset: const Offset(5, 5),
              ),
            ],
          ),
        ),
        WhisprRadialVisualizer(
            level: amplitudeLevel,
            center: Material(
              elevation: 10,
              shadowColor: WhisprColors.mauve,
              color: Colors.transparent,
              shape: const CircleBorder(),
              clipBehavior: Clip.antiAlias,
              child: Ink(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: WhisprGradient.purplePinkGradient,
                ),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  // match splash shape
                  splashColor: Colors.white.withValues(alpha: 0.2),
                  highlightColor: Colors.white.withValues(alpha: 0.08),
                  onTap: onClick,
                  child: FractionallySizedBox(
                    widthFactor: 0.65,
                    heightFactor: 0.65,
                    child: LayoutBuilder(builder: (context, constraints) {
                      return Center(
                        child: Icon(
                          Icons.mic_rounded,
                          color: Colors.white,
                          size: constraints.maxWidth * 0.4,
                        ),
                      );
                    }),
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
