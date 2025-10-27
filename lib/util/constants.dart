import 'package:logger/logger.dart';

abstract class Constants {
  static Logger logger = Logger();
}

abstract class ImageConstants {
  static String emptyJournalImage = 'assets/images/img_empty_journal.png';
  static String onboardingBgImage = 'assets/images/img_onboarding_bg.png';
  static String emptyFavouriteImage = 'assets/images/img_empty_favourite.png';
}

abstract class WhisprDuration {
  static const int onboardingNavigationTransitionDuration = 700;
  static const int navigationTransitionDuration = 400;
  static const int stateFadeTransitionMillis = 400;
  static const int animatedContainerMillis = 250;
  static const int amplitudeStreamUpdateMillis = 100;
  static const int timerTickUpdateMillis = 100;
}

abstract class DateFormatConstants {
  static const String fileTimestamp = 'yyyyMMdd_HHmmss';
  static const String timeFormat = 'HH:mm';
  static const String dateFormat = 'dd MMMM yyyy';
  static const String dateIndexFormat = 'yyyyMMdd';
  static const String monthDateYearFormat = 'MMM dd, yyyy';
}
