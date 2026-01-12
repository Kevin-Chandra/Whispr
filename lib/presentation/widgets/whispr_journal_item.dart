import 'package:flutter/material.dart';
import 'package:whispr/domain/entities/audio_recording.dart';
import 'package:whispr/domain/entities/mood.dart';
import 'package:whispr/presentation/themes/colors.dart';
import 'package:whispr/presentation/themes/text_styles.dart';
import 'package:whispr/presentation/widgets/animation/whispr_playing_audio_indicator_animation.dart';
import 'package:whispr/util/constants.dart';
import 'package:whispr/util/date_time_util.dart';

class WhisprJournalItem extends StatelessWidget {
  const WhisprJournalItem({
    super.key,
    required this.isSelected,
    required this.audioRecording,
    required this.onFavouritePressed,
    required this.isLastItem,
    required this.expandedWidget,
    required this.onPressed,
    required this.isPlayingAudio,
    this.useDotAndLine = true,
    this.cardPadding = EdgeInsets.zero,
  });

  final bool isSelected;
  final bool isLastItem;
  final bool isPlayingAudio;

  /// This will show dot and line, if this is `false`, then
  /// it will show full line instead.
  final bool useDotAndLine;
  final EdgeInsets cardPadding;
  final VoidCallback onFavouritePressed;
  final VoidCallback onPressed;
  final AudioRecording audioRecording;
  final Widget expandedWidget;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          left: 0,
          width: 45.0,
          child: useDotAndLine
              ? _DotAndLine(
                  isSelected: isSelected,
                  shouldDrawLine: !isLastItem,
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 21.5),
                  child: Container(
                    color: WhisprColors.vistaBlue.withValues(alpha: 0.5),
                    width: 2,
                  ),
                ),
        ),
        Padding(
          padding: cardPadding + EdgeInsets.only(left: 50.0),
          child: DecoratedBox(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: WhisprColors.lavenderWeb,
                blurRadius: 5,
                offset: Offset(0, 3),
              )
            ], borderRadius: BorderRadius.circular(15)),
            child: Card.filled(
              elevation: 0,
              color: isSelected ? Colors.white : WhisprColors.ghostWhite,
              surfaceTintColor: Colors.transparent,
              margin: EdgeInsets.zero,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                highlightColor:
                    WhisprColors.lavenderBlue.withValues(alpha: 0.2),
                splashColor: WhisprColors.lavenderBlue.withValues(alpha: 0.1),
                onTap: onPressed,
                child: _JournalItemCardContent(
                  isSelected: isSelected,
                  isPlayingAudio: isPlayingAudio,
                  audioRecording: audioRecording,
                  onFavouritePressed: onFavouritePressed,
                  expandedWidget: expandedWidget,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _JournalItemCardContent extends StatelessWidget {
  const _JournalItemCardContent({
    required this.isSelected,
    required this.isPlayingAudio,
    required this.audioRecording,
    required this.onFavouritePressed,
    required this.expandedWidget,
  });

  final bool isSelected;
  final bool isPlayingAudio;
  final AudioRecording audioRecording;
  final VoidCallback onFavouritePressed;
  final Widget expandedWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isSelected
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Image.asset(
                        audioRecording.mood.imageAsset,
                        width: 50,
                        height: 50,
                      ),
                    )
                  : const SizedBox(),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      audioRecording.createdAt.formattedTime,
                      textAlign: TextAlign.start,
                      style: WhisprTextStyles.subtitle2
                          .copyWith(color: WhisprColors.vodka),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        !isSelected && isPlayingAudio
                            ? Container(
                                height: 32,
                                padding: const EdgeInsets.all(8.0),
                                child: WhisprPlayingAudioIndicator(
                                  minBarHeight: 2,
                                  maxBarHeight: 12,
                                  barWidth: 4,
                                  gap: 4,
                                ),
                              )
                            : const SizedBox(),
                        Expanded(
                          child: Text(
                            audioRecording.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.start,
                            style: WhisprTextStyles.heading5.copyWith(
                              color: WhisprColors.spanishViolet,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      audioRecording.tags.map((tag) => '#${tag.label} ').join(),
                      textAlign: TextAlign.start,
                      style: WhisprTextStyles.subtitle2
                          .copyWith(color: WhisprColors.paleViolet),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onFavouritePressed,
                color: WhisprColors.lavenderFloral
                    .withValues(alpha: audioRecording.isFavourite ? 1 : 0.75),
                icon: Icon(
                  audioRecording.isFavourite
                      ? Icons.favorite
                      : Icons.favorite_border,
                ),
              )
            ],
          ),
          AnimatedSize(
            duration:
                Duration(milliseconds: WhisprDuration.animatedContainerMillis),
            curve: Curves.easeInOut,
            child: isSelected ? expandedWidget : const SizedBox(),
          ),
        ],
      ),
    );
  }
}

class _DotAndLine extends StatelessWidget {
  const _DotAndLine({
    required this.isSelected,
    required this.shouldDrawLine,
  });

  final bool isSelected;
  final bool shouldDrawLine;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DotAndLinePainter(
          isSelected: isSelected, shouldDrawLine: shouldDrawLine),
    );
  }
}

class _DotAndLinePainter extends CustomPainter {
  const _DotAndLinePainter({
    required this.isSelected,
    required this.shouldDrawLine,
  });

  final bool isSelected;
  final bool shouldDrawLine;

  @override
  void paint(Canvas canvas, Size size) {
    final topCenter = size.topCenter(Offset.zero);
    final bottomCenter = size.bottomCenter(Offset.zero);
    final strokeWidth = 2.0;
    final circleSpacing = 2.0;
    final padding = 8.0;
    double circleRadius = 6;
    Offset circleCenter;

    final paint = Paint()
      ..color = WhisprColors.lavenderBlue.withValues(alpha: 0.6)
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    if (isSelected) {
      circleRadius *= 0.75;
      circleCenter = topCenter +
          Offset(
              0,
              (circleRadius + (strokeWidth + circleSpacing) * 2) +
                  strokeWidth / 2);

      final fillPaint = Paint()
        ..color = WhisprColors.lavenderBlue
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final ringPaint = Paint()
        ..style = PaintingStyle.stroke
        ..color = WhisprColors.lavenderBlue.withValues(alpha: 0.4)
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final outerRingPaint = Paint()
        ..style = PaintingStyle.stroke
        ..color = WhisprColors.vistaBlue.withValues(alpha: 0.1)
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawCircle(circleCenter, circleRadius, fillPaint);
      circleRadius += strokeWidth + circleSpacing;
      canvas.drawCircle(circleCenter, circleRadius, ringPaint);
      circleRadius += strokeWidth + circleSpacing;
      canvas.drawCircle(circleCenter, circleRadius, outerRingPaint);
    } else {
      circleCenter = topCenter + Offset(0, (circleRadius + strokeWidth / 2));

      final strokePaint = Paint()
        ..style = PaintingStyle.stroke
        ..color = WhisprColors.lavenderBlue.withValues(alpha: 0.6)
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawCircle(circleCenter, circleRadius, strokePaint);
    }

    if (shouldDrawLine) {
      final lineStart =
          circleCenter + Offset(0, circleRadius + strokeWidth / 2 + padding);
      final lineEnd = bottomCenter;

      canvas.drawLine(lineStart, lineEnd, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _DotAndLinePainter oldDelegate) {
    return oldDelegate.isSelected != isSelected;
  }
}
