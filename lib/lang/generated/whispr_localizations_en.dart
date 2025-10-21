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
  String get discard => 'Discard';

  @override
  String get recordingWillNotBeSaved => 'Your recording will not be saved';

  @override
  String get failedToSaveAudioRecording => 'Failed to save audio recording!';

  @override
  String get titleEmptyErrorMessage =>
      'Oops — don’t forget to give this a name.';

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
