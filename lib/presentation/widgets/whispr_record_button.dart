import 'package:flutter/material.dart';
import 'package:whispr/presentation/themes/whispr_gradient.dart';
import 'package:whispr/presentation/widgets/whispr_radial_visualizer.dart';

class WhisprRecordButton extends StatelessWidget {
  const WhisprRecordButton({
    super.key,
    required this.onClick,
    this.amplitudeLevel,
  });

  final VoidCallback onClick;
  final Stream<double?>? amplitudeLevel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        // Isolate the background gradient container
        RepaintBoundary(
          child: Container(
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
        ),
        // Isolate the visualizer
        RepaintBoundary(
          child: WhisprRadialVisualizer(
            levelStream: amplitudeLevel ?? Stream.value(null),
            center: null, // Move center outside
          ),
        ),
        // Isolate the button
        RepaintBoundary(
          child: FractionallySizedBox(
            widthFactor: 0.65,
            heightFactor: 0.65,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    blurRadius: 36,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Material(
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
                    splashColor: Colors.white.withValues(alpha: 0.2),
                    highlightColor: Colors.white.withValues(alpha: 0.08),
                    onTap: onClick,
                    child: Center(
                      child: LayoutBuilder(builder: (context, constraints) {
                        return Icon(
                          Icons.mic_rounded,
                          color: Colors.white,
                          size: constraints.maxWidth * 0.4,
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
