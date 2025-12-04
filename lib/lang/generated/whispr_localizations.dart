import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'whispr_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of WhisprLocalizations
/// returned by `WhisprLocalizations.of(context)`.
///
/// Applications need to include `WhisprLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/whispr_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: WhisprLocalizations.localizationsDelegates,
///   supportedLocales: WhisprLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the WhisprLocalizations.supportedLocales
/// property.
abstract class WhisprLocalizations {
  WhisprLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static WhisprLocalizations? of(BuildContext context) {
    return Localizations.of<WhisprLocalizations>(context, WhisprLocalizations);
  }

  static const LocalizationsDelegate<WhisprLocalizations> delegate =
      _WhisprLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('en')];

  /// No description provided for @voice_record.
  ///
  /// In en, this message translates to:
  /// **'Voice Record'**
  String get voice_record;

  /// No description provided for @record.
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get record;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @goToSettings.
  ///
  /// In en, this message translates to:
  /// **'Go to settings'**
  String get goToSettings;

  /// No description provided for @allow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get allow;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @shareYourThoughts.
  ///
  /// In en, this message translates to:
  /// **'Share your thoughts'**
  String get shareYourThoughts;

  /// No description provided for @recording.
  ///
  /// In en, this message translates to:
  /// **'Recording...'**
  String get recording;

  /// No description provided for @paused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get paused;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @journal.
  ///
  /// In en, this message translates to:
  /// **'Journal'**
  String get journal;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @favourite.
  ///
  /// In en, this message translates to:
  /// **'Favourite'**
  String get favourite;

  /// No description provided for @happy.
  ///
  /// In en, this message translates to:
  /// **'Happy'**
  String get happy;

  /// No description provided for @sad.
  ///
  /// In en, this message translates to:
  /// **'Sad'**
  String get sad;

  /// No description provided for @angry.
  ///
  /// In en, this message translates to:
  /// **'Angry'**
  String get angry;

  /// No description provided for @shock.
  ///
  /// In en, this message translates to:
  /// **'Shock'**
  String get shock;

  /// No description provided for @flirty.
  ///
  /// In en, this message translates to:
  /// **'Flirty'**
  String get flirty;

  /// No description provided for @calm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get calm;

  /// No description provided for @playful.
  ///
  /// In en, this message translates to:
  /// **'Playful'**
  String get playful;

  /// No description provided for @smooch.
  ///
  /// In en, this message translates to:
  /// **'Smooch'**
  String get smooch;

  /// No description provided for @tired.
  ///
  /// In en, this message translates to:
  /// **'Tired'**
  String get tired;

  /// No description provided for @confused.
  ///
  /// In en, this message translates to:
  /// **'Confused'**
  String get confused;

  /// No description provided for @whatWouldYouLikeToNameThis.
  ///
  /// In en, this message translates to:
  /// **'What would you like to name this?'**
  String get whatWouldYouLikeToNameThis;

  /// No description provided for @whatIsThisAbout.
  ///
  /// In en, this message translates to:
  /// **'What is this about?'**
  String get whatIsThisAbout;

  /// No description provided for @selectAMood.
  ///
  /// In en, this message translates to:
  /// **'Select a mood'**
  String get selectAMood;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @saveEntry.
  ///
  /// In en, this message translates to:
  /// **'Save Entry'**
  String get saveEntry;

  /// No description provided for @discardRecording.
  ///
  /// In en, this message translates to:
  /// **'Discard recording?'**
  String get discardRecording;

  /// No description provided for @discardChanges.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get discardChanges;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @changesWillBeLost.
  ///
  /// In en, this message translates to:
  /// **'Changes will be lost'**
  String get changesWillBeLost;

  /// No description provided for @recordingWillNotBeSaved.
  ///
  /// In en, this message translates to:
  /// **'Your recording will not be saved'**
  String get recordingWillNotBeSaved;

  /// No description provided for @failedToSaveAudioRecording.
  ///
  /// In en, this message translates to:
  /// **'Failed to save audio recording!'**
  String get failedToSaveAudioRecording;

  /// No description provided for @titleEmptyErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Oops — don’t forget to give this a name.'**
  String get titleEmptyErrorMessage;

  /// No description provided for @recorderError.
  ///
  /// In en, this message translates to:
  /// **'Recorder error!'**
  String get recorderError;

  /// No description provided for @loadingAudioPlaybackError.
  ///
  /// In en, this message translates to:
  /// **'Loading audio playback error!'**
  String get loadingAudioPlaybackError;

  /// No description provided for @recordingSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Recording saved successfully!'**
  String get recordingSavedSuccessfully;

  /// No description provided for @addNewRecording.
  ///
  /// In en, this message translates to:
  /// **'Add new recording'**
  String get addNewRecording;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteFile.
  ///
  /// In en, this message translates to:
  /// **'Delete File?'**
  String get deleteFile;

  /// No description provided for @areYouSureYouWantToDeleteFile.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{file_name}\"? This action cannot be undone.'**
  String areYouSureYouWantToDeleteFile(String file_name);

  /// No description provided for @audioRecordingSuccessfullyDeleted.
  ///
  /// In en, this message translates to:
  /// **'Audio recording successfully deleted!'**
  String get audioRecordingSuccessfullyDeleted;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @journalEmptyPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Looks like this space is still quiet. When you’re ready, I’m here to listen.'**
  String get journalEmptyPlaceholder;

  /// No description provided for @showAllTagOptionsHint.
  ///
  /// In en, this message translates to:
  /// **'Type \'#\' to show all options.'**
  String get showAllTagOptionsHint;

  /// No description provided for @createNewTag.
  ///
  /// In en, this message translates to:
  /// **'Create new tag'**
  String get createNewTag;

  /// No description provided for @whispr.
  ///
  /// In en, this message translates to:
  /// **'Whispr'**
  String get whispr;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Voice, Your Story.'**
  String get onboardingTitle;

  /// No description provided for @onboardingMessage.
  ///
  /// In en, this message translates to:
  /// **'Capture and share your thoughts effortlessly. Whispr helps you record, save, and revisit what matters most.'**
  String get onboardingMessage;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started.'**
  String get getStarted;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error!'**
  String get error;

  /// No description provided for @lockScreenNotSetUpMessage.
  ///
  /// In en, this message translates to:
  /// **'Please set up a device lock screen before continuing'**
  String get lockScreenNotSetUpMessage;

  /// No description provided for @biometricHardwareNotAvailableMessage.
  ///
  /// In en, this message translates to:
  /// **'Looks like your device doesn’t support biometric authentication'**
  String get biometricHardwareNotAvailableMessage;

  /// No description provided for @temporaryLockoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts! Take a short break and try again in a bit'**
  String get temporaryLockoutMessage;

  /// No description provided for @unknownErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error happened.'**
  String get unknownErrorMessage;

  /// No description provided for @privacyAndSecurity.
  ///
  /// In en, this message translates to:
  /// **'Privacy & Security'**
  String get privacyAndSecurity;

  /// No description provided for @appLock.
  ///
  /// In en, this message translates to:
  /// **'App Lock'**
  String get appLock;

  /// No description provided for @thisAppIsProtected.
  ///
  /// In en, this message translates to:
  /// **'This app is protected.'**
  String get thisAppIsProtected;

  /// No description provided for @unlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlock;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'App version: {version} ({build_number})'**
  String appVersion(String version, String build_number);

  /// No description provided for @addFavourites.
  ///
  /// In en, this message translates to:
  /// **'Add Favourites'**
  String get addFavourites;

  /// No description provided for @noFavouritesYet.
  ///
  /// In en, this message translates to:
  /// **'No favourites yet!'**
  String get noFavouritesYet;

  /// No description provided for @noFavouritesMessage.
  ///
  /// In en, this message translates to:
  /// **'Mark the moments that matter — tap the heart button ❤ to save them here.'**
  String get noFavouritesMessage;

  /// No description provided for @backupAndRestore.
  ///
  /// In en, this message translates to:
  /// **'Backup & Restore'**
  String get backupAndRestore;

  /// No description provided for @backup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backup;

  /// No description provided for @exportData.
  ///
  /// In en, this message translates to:
  /// **'Export Data'**
  String get exportData;

  /// No description provided for @exportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can export your recordings and notes anytime.'**
  String get exportSubtitle;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @exporting.
  ///
  /// In en, this message translates to:
  /// **'Exporting...'**
  String get exporting;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to;

  /// No description provided for @fileName.
  ///
  /// In en, this message translates to:
  /// **'File Name'**
  String get fileName;

  /// No description provided for @recordingCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{No recording found} =1{Found 1 recording} other{Found {count} recordings}}'**
  String recordingCount(num count);

  /// No description provided for @backupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup Success!'**
  String get backupSuccess;

  /// No description provided for @backupFailed.
  ///
  /// In en, this message translates to:
  /// **'Backup Failed!'**
  String get backupFailed;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @restoreFailed.
  ///
  /// In en, this message translates to:
  /// **'Restore Failed!'**
  String get restoreFailed;

  /// No description provided for @restoreSuccess.
  ///
  /// In en, this message translates to:
  /// **'Restore Success'**
  String get restoreSuccess;

  /// No description provided for @restoreWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning: Importing this file will remove all your current recordings and notes. Do you wish to proceed?'**
  String get restoreWarning;

  /// No description provided for @proceed.
  ///
  /// In en, this message translates to:
  /// **'Proceed'**
  String get proceed;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @importSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can import your saved recordings and notes anytime. Importing will remove all your current recording.'**
  String get importSubtitle;

  /// No description provided for @selectAFile.
  ///
  /// In en, this message translates to:
  /// **'Select a file'**
  String get selectAFile;

  /// No description provided for @storage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get storage;

  /// No description provided for @clearAllData.
  ///
  /// In en, this message translates to:
  /// **'Clear all data'**
  String get clearAllData;

  /// No description provided for @clearAllDataSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successfully cleared all data'**
  String get clearAllDataSuccess;

  /// No description provided for @clearAllDataWarning.
  ///
  /// In en, this message translates to:
  /// **'All your recordings and backup files will be deleted. This process is IRREVERSIBLE. Do you wish to delete?'**
  String get clearAllDataWarning;

  /// No description provided for @deleteForever.
  ///
  /// In en, this message translates to:
  /// **'Delete forever'**
  String get deleteForever;

  /// No description provided for @clearAllDataSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Clearing all data will remove all your current recordings and notes. This action cannot be undone.'**
  String get clearAllDataSubtitle;

  /// No description provided for @typeDeleteToConfirm.
  ///
  /// In en, this message translates to:
  /// **'Type \"{keyword}\" to confirm'**
  String typeDeleteToConfirm(String keyword);

  /// No description provided for @microphonePermissionDeniedTitle.
  ///
  /// In en, this message translates to:
  /// **'Please allow us to record audio'**
  String get microphonePermissionDeniedTitle;

  /// No description provided for @microphonePermissionDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'Whispr need the microphone access to record your story.'**
  String get microphonePermissionDeniedMessage;

  /// No description provided for @microphonePermissionDeniedForeverTitle.
  ///
  /// In en, this message translates to:
  /// **'Whispr require microphone access'**
  String get microphonePermissionDeniedForeverTitle;

  /// No description provided for @microphonePermissionDeniedForeverMessage.
  ///
  /// In en, this message translates to:
  /// **'Please go to settings to allow microphone access.'**
  String get microphonePermissionDeniedForeverMessage;
}

class _WhisprLocalizationsDelegate
    extends LocalizationsDelegate<WhisprLocalizations> {
  const _WhisprLocalizationsDelegate();

  @override
  Future<WhisprLocalizations> load(Locale locale) {
    return SynchronousFuture<WhisprLocalizations>(
        lookupWhisprLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_WhisprLocalizationsDelegate old) => false;
}

WhisprLocalizations lookupWhisprLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return WhisprLocalizationsEn();
  }

  throw FlutterError(
      'WhisprLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
