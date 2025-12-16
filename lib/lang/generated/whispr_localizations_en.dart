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
  String get shareYourThoughts => 'Share your thoughts';

  @override
  String get recording => 'Recording...';

  @override
  String get paused => 'Paused';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Resume';

  @override
  String get journal => 'Journal';

  @override
  String get settings => 'Settings';

  @override
  String get favourite => 'Favourite';

  @override
  String get happy => 'Happy';

  @override
  String get sad => 'Sad';

  @override
  String get angry => 'Angry';

  @override
  String get shock => 'Shock';

  @override
  String get flirty => 'Flirty';

  @override
  String get calm => 'Calm';

  @override
  String get playful => 'Playful';

  @override
  String get smooch => 'Smooch';

  @override
  String get tired => 'Tired';

  @override
  String get confused => 'Confused';

  @override
  String get whatWouldYouLikeToNameThis => 'What would you like to name this?';

  @override
  String get whatIsThisAbout => 'What is this about?';

  @override
  String get selectAMood => 'Select a mood';

  @override
  String get tags => 'Tags';

  @override
  String get saveEntry => 'Save Entry';

  @override
  String get discardRecording => 'Discard recording?';

  @override
  String get discardChanges => 'Discard changes?';

  @override
  String get discard => 'Discard';

  @override
  String get changesWillBeLost => 'Changes will be lost';

  @override
  String get recordingWillNotBeSaved => 'Your recording will not be saved';

  @override
  String get failedToSaveAudioRecording => 'Failed to save audio recording!';

  @override
  String get titleEmptyErrorMessage =>
      'Oops — Don’t forget to give this a name.';

  @override
  String get recorderError => 'Recorder error!';

  @override
  String get loadingAudioPlaybackError => 'Loading audio playback error!';

  @override
  String get recordingSavedSuccessfully => 'Recording saved successfully!';

  @override
  String get addNewRecording => 'Add new recording';

  @override
  String get delete => 'Delete';

  @override
  String get deleteFile => 'Delete File?';

  @override
  String areYouSureYouWantToDeleteFile(String file_name) {
    return 'Are you sure you want to delete \"$file_name\"? This action cannot be undone.';
  }

  @override
  String get audioRecordingSuccessfullyDeleted =>
      'Audio recording successfully deleted!';

  @override
  String get today => 'Today';

  @override
  String get journalEmptyPlaceholder =>
      'Looks like this space is still quiet. When you’re ready, I’m here to listen.';

  @override
  String get showAllTagOptionsHint => 'Type \'#\' to show all options.';

  @override
  String get createNewTag => 'Create new tag';

  @override
  String get whispr => 'Whispr';

  @override
  String get onboardingTitle => 'Your Voice, Your Story.';

  @override
  String get onboardingMessage =>
      'Capture and share your thoughts effortlessly. Whispr helps you record, save, and revisit what matters most.';

  @override
  String get getStarted => 'Get Started.';

  @override
  String get error => 'Error!';

  @override
  String get lockScreenNotSetUpMessage =>
      'Please set up a device lock screen before continuing';

  @override
  String get biometricHardwareNotAvailableMessage =>
      'Looks like your device doesn’t support biometric authentication';

  @override
  String get temporaryLockoutMessage =>
      'Too many attempts! Take a short break and try again in a bit';

  @override
  String get unknownErrorMessage => 'An unexpected error happened.';

  @override
  String get privacyAndSecurity => 'Privacy & Security';

  @override
  String get appLock => 'App Lock';

  @override
  String get thisAppIsProtected => 'This app is protected.';

  @override
  String get unlock => 'Unlock';

  @override
  String appVersion(String version, String build_number) {
    return 'App version: $version ($build_number)';
  }

  @override
  String get addFavourites => 'Add Favourites';

  @override
  String get noFavouritesYet => 'No favourites yet!';

  @override
  String get noFavouritesMessage =>
      'Mark the moments that matter — tap the heart button ❤ to save them here.';

  @override
  String get backupAndRestore => 'Backup & Restore';

  @override
  String get backup => 'Backup';

  @override
  String get exportData => 'Export Data';

  @override
  String get exportSubtitle =>
      'You can export your recordings and notes anytime.';

  @override
  String get export => 'Export';

  @override
  String get exporting => 'Exporting...';

  @override
  String get from => 'From';

  @override
  String get to => 'To';

  @override
  String get fileName => 'File Name';

  @override
  String recordingCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Found $count recordings',
      one: 'Found 1 recording',
      zero: 'No recording found',
    );
    return '$_temp0';
  }

  @override
  String get backupSuccess => 'Backup Success!';

  @override
  String get backupFileSaved => 'Backup file successfully saved!';

  @override
  String get backupFailed => 'Backup Failed!';

  @override
  String get restore => 'Restore';

  @override
  String get restoreFailed => 'Restore Failed!';

  @override
  String get restoreSuccess => 'Restore Success';

  @override
  String get restoreWarning =>
      'Warning: Importing this file will remove all your current recordings and notes. Do you wish to proceed?';

  @override
  String get proceed => 'Proceed';

  @override
  String get import => 'Import';

  @override
  String get importSubtitle =>
      'You can import your saved recordings and notes anytime. Importing will remove all your current recording.';

  @override
  String get selectAFile => 'Select a file';

  @override
  String get storage => 'Storage';

  @override
  String get clearAllData => 'Clear all data';

  @override
  String get clearAllDataSuccess => 'Successfully cleared all data';

  @override
  String get clearAllDataWarning =>
      'All your recordings and backup files will be deleted. This process is IRREVERSIBLE. Do you wish to delete?';

  @override
  String get deleteForever => 'Delete forever';

  @override
  String get clearAllDataSubtitle =>
      'Clearing all data will remove all your current recordings and notes. This action cannot be undone.';

  @override
  String typeDeleteToConfirm(String keyword) {
    return 'Type \"$keyword\" to confirm';
  }

  @override
  String get recentBackup => 'Recent backup';

  @override
  String get justNow => 'just now';

  @override
  String minutesAgo(int minutes) {
    return '$minutes minutes ago';
  }

  @override
  String hoursAgo(int hours) {
    return '$hours hours ago';
  }

  @override
  String daysAgo(int days) {
    return '$days days ago';
  }

  @override
  String lastBackup(String time) {
    return 'Last backup $time';
  }

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
