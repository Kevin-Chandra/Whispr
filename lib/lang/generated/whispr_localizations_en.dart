// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'whispr_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class WhisprLocalizationsEn extends WhisprLocalizations {
  WhisprLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get voice_record => 'Voice Record';

  @override
  String get record => 'Record';

  @override
  String get home => 'Home';

  @override
  String get ok => 'Ok';

  @override
  String get notNow => 'Not now';

  @override
  String get goToSettings => 'Go to settings';

  @override
  String get allow => 'Allow';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get close => 'Close';

  @override
  String get microphonePermissionDeniedTitle =>
      'Please allow us to record audio';

  @override
  String get microphonePermissionDeniedMessage =>
      'Whispr need the microphone access to record your story.';

  @override
  String get microphonePermissionDeniedForeverTitle =>
      'Whispr require microphone access';

  @override
  String get microphonePermissionDeniedForeverMessage =>
      'Please go to settings to allow microphone access.';
}
