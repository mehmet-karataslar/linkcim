import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('tr')
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Linkcim'**
  String get appTitle;

  /// Home page title
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Add video button
  ///
  /// In en, this message translates to:
  /// **'Add Video'**
  String get addVideo;

  /// Edit video title
  ///
  /// In en, this message translates to:
  /// **'Edit Video'**
  String get editVideo;

  /// Search button
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Settings page title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Video title label
  ///
  /// In en, this message translates to:
  /// **'Video Title'**
  String get videoTitle;

  /// Video description label
  ///
  /// In en, this message translates to:
  /// **'Video Description'**
  String get videoDescription;

  /// Category label
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Tags label
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// Save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Update button
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Delete button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Edit button
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No videos message
  ///
  /// In en, this message translates to:
  /// **'No videos added yet'**
  String get noVideos;

  /// Add first video message
  ///
  /// In en, this message translates to:
  /// **'Add your first video'**
  String get addFirstVideo;

  /// All categories filter
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allCategories;

  /// Video URL label
  ///
  /// In en, this message translates to:
  /// **'Video URL'**
  String get videoUrl;

  /// Video URL input placeholder
  ///
  /// In en, this message translates to:
  /// **'Enter video URL'**
  String get enterVideoUrl;

  /// Invalid URL error
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid video URL'**
  String get invalidUrl;

  /// Required field label
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// Optional field label
  ///
  /// In en, this message translates to:
  /// **'Optional'**
  String get optional;

  /// Language selection label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Turkish language option
  ///
  /// In en, this message translates to:
  /// **'Turkish'**
  String get turkish;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Theme selection label
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light Theme'**
  String get lightTheme;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;

  /// System theme option
  ///
  /// In en, this message translates to:
  /// **'System Theme'**
  String get systemTheme;

  /// Permissions section
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get permissions;

  /// Storage permissions title
  ///
  /// In en, this message translates to:
  /// **'Storage Permissions'**
  String get storagePermissions;

  /// Manage permissions button
  ///
  /// In en, this message translates to:
  /// **'Manage Permissions'**
  String get managePermissions;

  /// System settings button
  ///
  /// In en, this message translates to:
  /// **'System Settings'**
  String get systemSettings;

  /// Data management section
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get dataManagement;

  /// Clear all data button
  ///
  /// In en, this message translates to:
  /// **'Clear All Data'**
  String get clearAllData;

  /// Clear data warning
  ///
  /// In en, this message translates to:
  /// **'This action will delete all your videos and cannot be undone. Are you sure you want to continue?'**
  String get clearDataWarning;

  /// About button
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Application description
  ///
  /// In en, this message translates to:
  /// **'Smart Video Recording and Categorization Application'**
  String get appInfo;

  /// Add tag label
  ///
  /// In en, this message translates to:
  /// **'Add Tag'**
  String get addTag;

  /// Tag input placeholder
  ///
  /// In en, this message translates to:
  /// **'Enter tag and press Enter'**
  String get enterTag;

  /// New video button
  ///
  /// In en, this message translates to:
  /// **'New Video'**
  String get newVideo;

  /// Edit video title
  ///
  /// In en, this message translates to:
  /// **'Edit Video Information'**
  String get editVideoInfo;

  /// Add video description
  ///
  /// In en, this message translates to:
  /// **'Enter video information and add to your collection'**
  String get videoInfoDescription;

  /// Category selection placeholder
  ///
  /// In en, this message translates to:
  /// **'Select video category'**
  String get selectCategory;

  /// Video saved message
  ///
  /// In en, this message translates to:
  /// **'Video saved successfully'**
  String get videoSaved;

  /// Video updated message
  ///
  /// In en, this message translates to:
  /// **'Video updated'**
  String get videoUpdated;

  /// Save error message
  ///
  /// In en, this message translates to:
  /// **'Save error'**
  String get saveError;

  /// All permissions granted message
  ///
  /// In en, this message translates to:
  /// **'All permissions granted'**
  String get allPermissionsGranted;

  /// Permissions missing message
  ///
  /// In en, this message translates to:
  /// **'Permissions missing'**
  String get permissionsMissing;

  /// Permission info description
  ///
  /// In en, this message translates to:
  /// **'Linkcim app requires the following permissions:'**
  String get permissionInfo;

  /// Storage access description
  ///
  /// In en, this message translates to:
  /// **'Storage Access'**
  String get storageAccess;

  /// Storage access description
  ///
  /// In en, this message translates to:
  /// **'To access app data'**
  String get storageAccessDesc;

  /// Video/Media access title
  ///
  /// In en, this message translates to:
  /// **'Video/Media Access'**
  String get videoMediaAccess;

  /// Video/Media access description
  ///
  /// In en, this message translates to:
  /// **'To access video files'**
  String get videoMediaAccessDesc;

  /// File management title
  ///
  /// In en, this message translates to:
  /// **'File Management'**
  String get fileManagement;

  /// File management description
  ///
  /// In en, this message translates to:
  /// **'To organize video files'**
  String get fileManagementDesc;

  /// Data privacy message
  ///
  /// In en, this message translates to:
  /// **'Your data is safe, only used for app functionality.'**
  String get dataPrivacy;

  /// Requesting permissions message
  ///
  /// In en, this message translates to:
  /// **'Requesting permissions...'**
  String get requestingPermissions;

  /// Permissions granted message
  ///
  /// In en, this message translates to:
  /// **'All permissions granted!'**
  String get permissionsGranted;

  /// Permissions denied message
  ///
  /// In en, this message translates to:
  /// **'Some permissions were denied.'**
  String get permissionsDenied;

  /// Data cleared message
  ///
  /// In en, this message translates to:
  /// **'All data cleared'**
  String get dataCleared;

  /// Clear data error
  ///
  /// In en, this message translates to:
  /// **'Error occurred while clearing data'**
  String get clearDataError;

  /// Application version label
  ///
  /// In en, this message translates to:
  /// **'Application Version'**
  String get appVersion;

  /// Development info
  ///
  /// In en, this message translates to:
  /// **'Developed with Flutter.'**
  String get developedWith;

  /// Search placeholder
  ///
  /// In en, this message translates to:
  /// **'Search your videos...'**
  String get searchVideos;

  /// Video loading message
  ///
  /// In en, this message translates to:
  /// **'Loading videos...'**
  String get videosLoading;

  /// No video found message
  ///
  /// In en, this message translates to:
  /// **'No video found'**
  String get noVideoFound;

  /// Try different keywords message
  ///
  /// In en, this message translates to:
  /// **'Try different keywords.'**
  String get tryDifferentKeywords;

  /// Add first video button
  ///
  /// In en, this message translates to:
  /// **'Add Your First Video'**
  String get addFirstVideoButton;

  /// Delete video title
  ///
  /// In en, this message translates to:
  /// **'Delete Video'**
  String get videoDelete;

  /// Delete confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this video?'**
  String get confirmDelete;

  /// Video deleted message
  ///
  /// In en, this message translates to:
  /// **'Video deleted'**
  String get videoDeleted;

  /// Video delete error
  ///
  /// In en, this message translates to:
  /// **'Video could not be deleted'**
  String get videoDeleteError;

  /// Data load error
  ///
  /// In en, this message translates to:
  /// **'Error occurred while loading data'**
  String get dataLoadError;

  /// Video URL required message
  ///
  /// In en, this message translates to:
  /// **'Video URL is required'**
  String get videoUrlRequired;

  /// Title required message
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get titleRequired;

  /// Category required message
  ///
  /// In en, this message translates to:
  /// **'Category is required'**
  String get categoryRequired;

  /// Title placeholder
  ///
  /// In en, this message translates to:
  /// **'Enter video title'**
  String get enterTitle;

  /// Description placeholder
  ///
  /// In en, this message translates to:
  /// **'Write a description about the video (optional)'**
  String get enterDescription;

  /// Tag count
  ///
  /// In en, this message translates to:
  /// **'Tags ({count}/10)'**
  String tagsCount(int count);

  /// Video search title
  ///
  /// In en, this message translates to:
  /// **'Video Search'**
  String get videoSearch;

  /// Search placeholder
  ///
  /// In en, this message translates to:
  /// **'Search videos... (title, author, platform, tag)'**
  String get searchPlaceholder;

  /// Clear search button
  ///
  /// In en, this message translates to:
  /// **'Clear Search'**
  String get clearSearch;

  /// Videos found message
  ///
  /// In en, this message translates to:
  /// **'{count} videos found'**
  String videosFound(int count);

  /// Search error message
  ///
  /// In en, this message translates to:
  /// **'Search error'**
  String get searchError;

  /// No video match message
  ///
  /// In en, this message translates to:
  /// **'No video found matching your search criteria.\nTry different keywords.'**
  String get noVideoMatch;

  /// Video statistics title
  ///
  /// In en, this message translates to:
  /// **'Video Statistics'**
  String get videoStatistics;

  /// Total videos label
  ///
  /// In en, this message translates to:
  /// **'Total Videos'**
  String get totalVideos;

  /// Categories label
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// Platform distribution title
  ///
  /// In en, this message translates to:
  /// **'Platform Distribution'**
  String get platformDistribution;

  /// Popular categories title
  ///
  /// In en, this message translates to:
  /// **'Popular Categories'**
  String get popularCategories;

  /// Refresh button
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// Share button
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// Preview button
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// Open button
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// Open in platform button
  ///
  /// In en, this message translates to:
  /// **'Open in Platform'**
  String get openInPlatform;

  /// Video information title
  ///
  /// In en, this message translates to:
  /// **'Video Information'**
  String get videoInfo;

  /// Duration label
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// Resolution label
  ///
  /// In en, this message translates to:
  /// **'Resolution'**
  String get resolution;

  /// File size label
  ///
  /// In en, this message translates to:
  /// **'File Size'**
  String get fileSize;

  /// File path label
  ///
  /// In en, this message translates to:
  /// **'File Path'**
  String get filePath;

  /// Calculating message
  ///
  /// In en, this message translates to:
  /// **'Calculating...'**
  String get calculating;

  /// Video loading message
  ///
  /// In en, this message translates to:
  /// **'Loading video...'**
  String get videoLoading;

  /// Cannot play video title
  ///
  /// In en, this message translates to:
  /// **'Cannot Play Video'**
  String get videoCannotPlay;

  /// Retry button
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Go back button
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// Unknown error message
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred'**
  String get unknownError;

  /// Video file not found message
  ///
  /// In en, this message translates to:
  /// **'Video file not found'**
  String get videoFileNotFound;

  /// Video file empty message
  ///
  /// In en, this message translates to:
  /// **'Video file is empty or cannot be read'**
  String get videoFileEmpty;

  /// Video load timeout message
  ///
  /// In en, this message translates to:
  /// **'Video loading timed out'**
  String get videoLoadTimeout;

  /// Video format not supported message
  ///
  /// In en, this message translates to:
  /// **'Video format not supported'**
  String get videoFormatNotSupported;

  /// No permission message
  ///
  /// In en, this message translates to:
  /// **'No permission to access video file'**
  String get noPermission;

  /// Video play error
  ///
  /// In en, this message translates to:
  /// **'Video cannot be played'**
  String get videoPlayError;

  /// Link open error
  ///
  /// In en, this message translates to:
  /// **'Link open error'**
  String get linkOpenError;

  /// Platform cannot open message
  ///
  /// In en, this message translates to:
  /// **'cannot be opened'**
  String get platformCannotOpen;

  /// Application description
  ///
  /// In en, this message translates to:
  /// **'Organize your videos and find them easily.'**
  String get organizeVideos;

  /// Manual edit permissions message
  ///
  /// In en, this message translates to:
  /// **'Manually edit app permissions'**
  String get manualEditPermissions;

  /// Checking permissions message
  ///
  /// In en, this message translates to:
  /// **'Checking permissions...'**
  String get checkingPermissions;

  /// Permission request error
  ///
  /// In en, this message translates to:
  /// **'Permission request error'**
  String get permissionRequestError;

  /// iOS auto permission message
  ///
  /// In en, this message translates to:
  /// **'Automatic permission granted on iOS devices'**
  String get iosAutoPermission;

  /// Careful use message
  ///
  /// In en, this message translates to:
  /// **'Use carefully - cannot be undone'**
  String get carefulUse;

  /// Application information label
  ///
  /// In en, this message translates to:
  /// **'Application information'**
  String get appInformation;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'tr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
