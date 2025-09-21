import 'package:flutter/material.dart';
import 'package:whispr/util/extensions.dart';

enum Mood {
  happy,
  sad,
  angry,
  shock,
  flirty,
  calm,
  playful,
  smooch,
  tired,
  confused
}

extension MoodExtension on Mood {
  String get imageAsset {
    switch (this) {
      case Mood.happy:
        return 'assets/images/emoji_happy.png';
      case Mood.sad:
        return 'assets/images/emoji_sad.png';
      case Mood.angry:
        return 'assets/images/emoji_angry.png';
      case Mood.shock:
        return 'assets/images/emoji_shock.png';
      case Mood.flirty:
        return 'assets/images/emoji_flirty.png';
      case Mood.calm:
        return 'assets/images/emoji_calm.png';
      case Mood.playful:
        return 'assets/images/emoji_playful.png';
      case Mood.smooch:
        return 'assets/images/emoji_smooch.png';
      case Mood.tired:
        return 'assets/images/emoji_tired.png';
      case Mood.confused:
        return 'assets/images/emoji_confused.png';
    }
  }

  String getDisplayName(BuildContext context) {
    switch (this) {
      case Mood.happy:
        return context.strings.happy;
      case Mood.sad:
        return context.strings.sad;
      case Mood.angry:
        return context.strings.angry;
      case Mood.shock:
        return context.strings.shock;
      case Mood.flirty:
        return context.strings.flirty;
      case Mood.calm:
        return context.strings.calm;
      case Mood.playful:
        return context.strings.playful;
      case Mood.smooch:
        return context.strings.smooch;
      case Mood.tired:
        return context.strings.tired;
      case Mood.confused:
        return context.strings.confused;
    }
  }
}
