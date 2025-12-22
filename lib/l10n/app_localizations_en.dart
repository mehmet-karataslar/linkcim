// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Linkcim';

  @override
  String get home => 'Home';

  @override
  String get addVideo => 'Add Video';

  @override
  String get editVideo => 'Edit Video';

  @override
  String get search => 'Search';

  @override
  String get settings => 'Settings';

  @override
  String get videoTitle => 'Video Title';

  @override
  String get videoDescription => 'Video Description';

  @override
  String get category => 'Category';

  @override
  String get tags => 'Tags';

  @override
  String get save => 'Save';

  @override
  String get update => 'Update';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get noVideos => 'No videos added yet';

  @override
  String get addFirstVideo => 'Add your first video';

  @override
  String get allCategories => 'All Categories';

  @override
  String get videoUrl => 'Video URL';

  @override
  String get enterVideoUrl => 'Enter video URL';

  @override
  String get invalidUrl => 'Please enter a valid video URL';

  @override
  String get required => 'Required';

  @override
  String get optional => 'Optional';

  @override
  String get language => 'Language';

  @override
  String get turkish => 'Turkish';

  @override
  String get english => 'English';

  @override
  String get theme => 'Theme';

  @override
  String get lightTheme => 'Light Theme';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get systemTheme => 'System Theme';

  @override
  String get permissions => 'Permissions';

  @override
  String get storagePermissions => 'Storage Permissions';

  @override
  String get managePermissions => 'Manage Permissions';

  @override
  String get systemSettings => 'System Settings';

  @override
  String get dataManagement => 'Data Management';

  @override
  String get clearAllData => 'Clear All Data';

  @override
  String get clearDataWarning =>
      'This action will delete all your videos and cannot be undone. Are you sure you want to continue?';

  @override
  String get about => 'About';

  @override
  String get appInfo => 'Smart Video Recording and Categorization Application';

  @override
  String get addTag => 'Add Tag';

  @override
  String get enterTag => 'Enter tag and press Enter';

  @override
  String get newVideo => 'New Video';

  @override
  String get editVideoInfo => 'Edit Video Information';

  @override
  String get videoInfoDescription =>
      'Enter video information and add to your collection';

  @override
  String get selectCategory => 'Select video category';

  @override
  String get videoSaved => 'Video saved successfully';

  @override
  String get videoUpdated => 'Video updated';

  @override
  String get saveError => 'Save error';

  @override
  String get allPermissionsGranted => 'All permissions granted';

  @override
  String get permissionsMissing => 'Permissions missing';

  @override
  String get permissionInfo =>
      'Linkcim app requires the following permissions:';

  @override
  String get storageAccess => 'Storage Access';

  @override
  String get storageAccessDesc => 'To access app data';

  @override
  String get videoMediaAccess => 'Video/Media Access';

  @override
  String get videoMediaAccessDesc => 'To access video files';

  @override
  String get fileManagement => 'File Management';

  @override
  String get fileManagementDesc => 'To organize video files';

  @override
  String get dataPrivacy =>
      'Your data is safe, only used for app functionality.';

  @override
  String get requestingPermissions => 'Requesting permissions...';

  @override
  String get permissionsGranted => 'All permissions granted!';

  @override
  String get permissionsDenied => 'Some permissions were denied.';

  @override
  String get dataCleared => 'All data cleared';

  @override
  String get clearDataError => 'Error occurred while clearing data';

  @override
  String get appVersion => 'Application Version';

  @override
  String get developedWith => 'Developed with Flutter.';

  @override
  String get searchVideos => 'Search your videos...';

  @override
  String get videosLoading => 'Loading videos...';

  @override
  String get noVideoFound => 'No video found';

  @override
  String get tryDifferentKeywords => 'Try different keywords.';

  @override
  String get addFirstVideoButton => 'Add Your First Video';

  @override
  String get videoDelete => 'Delete Video';

  @override
  String get confirmDelete => 'Are you sure you want to delete this video?';

  @override
  String get videoDeleted => 'Video deleted';

  @override
  String get videoDeleteError => 'Video could not be deleted';

  @override
  String get dataLoadError => 'Error occurred while loading data';

  @override
  String get videoUrlRequired => 'Video URL is required';

  @override
  String get titleRequired => 'Title is required';

  @override
  String get categoryRequired => 'Category is required';

  @override
  String get enterTitle => 'Enter video title';

  @override
  String get enterDescription =>
      'Write a description about the video (optional)';

  @override
  String tagsCount(int count) {
    return 'Tags ($count/10)';
  }

  @override
  String get videoSearch => 'Video Search';

  @override
  String get searchPlaceholder =>
      'Search videos... (title, author, platform, tag)';

  @override
  String get clearSearch => 'Clear Search';

  @override
  String videosFound(int count) {
    return '$count videos found';
  }

  @override
  String get searchError => 'Search error';

  @override
  String get noVideoMatch =>
      'No video found matching your search criteria.\nTry different keywords.';

  @override
  String get videoStatistics => 'Video Statistics';

  @override
  String get totalVideos => 'Total Videos';

  @override
  String get categories => 'Categories';

  @override
  String get platformDistribution => 'Platform Distribution';

  @override
  String get popularCategories => 'Popular Categories';

  @override
  String get refresh => 'Refresh';

  @override
  String get share => 'Share';

  @override
  String get preview => 'Preview';

  @override
  String get open => 'Open';

  @override
  String get openInPlatform => 'Open in Platform';

  @override
  String get videoInfo => 'Video Information';

  @override
  String get duration => 'Duration';

  @override
  String get resolution => 'Resolution';

  @override
  String get fileSize => 'File Size';

  @override
  String get filePath => 'File Path';

  @override
  String get calculating => 'Calculating...';

  @override
  String get videoLoading => 'Loading video...';

  @override
  String get videoCannotPlay => 'Cannot Play Video';

  @override
  String get retry => 'Retry';

  @override
  String get goBack => 'Go Back';

  @override
  String get unknownError => 'An unknown error occurred';

  @override
  String get videoFileNotFound => 'Video file not found';

  @override
  String get videoFileEmpty => 'Video file is empty or cannot be read';

  @override
  String get videoLoadTimeout => 'Video loading timed out';

  @override
  String get videoFormatNotSupported => 'Video format not supported';

  @override
  String get noPermission => 'No permission to access video file';

  @override
  String get videoPlayError => 'Video cannot be played';

  @override
  String get linkOpenError => 'Link opening error';

  @override
  String get platformCannotOpen => 'cannot be opened';

  @override
  String get organizeVideos => 'Organize your videos and find them easily.';

  @override
  String get manualEditPermissions => 'Manually edit app permissions';

  @override
  String get checkingPermissions => 'Checking permissions...';

  @override
  String get permissionRequestError => 'Permission request error';

  @override
  String get iosAutoPermission => 'Automatic permission granted on iOS devices';

  @override
  String get carefulUse => 'Use carefully - cannot be undone';

  @override
  String get appInformation => 'Application information';

  @override
  String get searchPlaceholderShort => 'Search...';

  @override
  String get shareVideoLink => 'Share Video Link';

  @override
  String get shareVideoLinkDesc => 'Via phone share menu';

  @override
  String get shareDetailedInfo => 'Share Detailed Info';

  @override
  String get shareDetailedInfoDesc => 'With title, description and tags';

  @override
  String get copyLink => 'Copy Link';

  @override
  String get copyLinkDesc => 'Copy to clipboard';

  @override
  String get linkCopied => 'Link copied to clipboard';

  @override
  String get shareError => 'Share error';

  @override
  String get copyError => 'Copy error';

  @override
  String get videoLinkShared => 'Video link shared';

  @override
  String get videoDetailsShared => 'Video details shared';

  @override
  String get loading => 'Loading...';

  @override
  String get previewLoading => 'Preview\nLoading...';

  @override
  String get previewUnavailable => 'Preview\nUnavailable';

  @override
  String get platformInstagram => 'Instagram';

  @override
  String get platformYouTube => 'YouTube';

  @override
  String get platformTikTok => 'TikTok';

  @override
  String get platformTwitter => 'Twitter';

  @override
  String get platformFacebook => 'Facebook';

  @override
  String get platformVimeo => 'Vimeo';

  @override
  String get platformReddit => 'Reddit';

  @override
  String get platformGeneral => 'General';

  @override
  String get categoryGeneral => 'General';

  @override
  String get categorySoftware => 'Software';

  @override
  String get categoryEducation => 'Education';

  @override
  String get categoryEntertainment => 'Entertainment';

  @override
  String get categorySports => 'Sports';

  @override
  String get categoryFood => 'Food';

  @override
  String get categoryMusic => 'Music';

  @override
  String get categoryArt => 'Art';

  @override
  String get categoryScience => 'Science';

  @override
  String get categoryTechnology => 'Technology';

  @override
  String get noDescription => 'No description';

  @override
  String get descriptionNotAvailable => 'Description not available';

  @override
  String get noTags => 'No tags';

  @override
  String get sharedFromLinkcim => 'Shared from Linkcim app';

  @override
  String videoCollection(int count) {
    return 'Video Collection ($count videos)';
  }

  @override
  String categoryVideos(String category) {
    return '$category Category';
  }

  @override
  String videosFoundInCategory(int count) {
    return '$count videos found';
  }

  @override
  String andMoreVideos(int count) {
    return '... and $count more videos';
  }

  @override
  String get videoTitleFromUrl => 'Video Title';

  @override
  String get instagramPost => 'Instagram Post';

  @override
  String get instagramReel => 'Instagram Reel';

  @override
  String get instagramTV => 'Instagram TV';

  @override
  String get instagramVideo => 'Instagram Video';

  @override
  String get youtubeVideo => 'YouTube Video';

  @override
  String get youtubeShorts => 'YouTube Shorts';

  @override
  String get tiktokVideo => 'TikTok Video';

  @override
  String get tiktokVideoShortLink => 'TikTok Video (Short Link)';

  @override
  String get twitterPost => 'Twitter Post';

  @override
  String twitterUser(String username) {
    return 'Twitter (@$username)';
  }

  @override
  String get xTwitterPost => 'X/Twitter Post';

  @override
  String xTwitterUser(String username) {
    return 'X/Twitter (@$username)';
  }

  @override
  String get facebookVideo => 'Facebook Video';

  @override
  String get vimeoVideo => 'Vimeo Video';

  @override
  String get redditVideo => 'Reddit Video';

  @override
  String get unknownChannel => 'Unknown Channel';

  @override
  String get quickShare => 'Quick Share';

  @override
  String get videoShared => 'Video shared';

  @override
  String shareFailed(String error) {
    return 'Share failed: $error';
  }

  @override
  String get grantPermission => 'Grant Permission';

  @override
  String get later => 'Later';

  @override
  String get videoAccess => 'Video Access';

  @override
  String get videoAccessDescription => 'To save and organize video links';

  @override
  String get collections => 'Collections';

  @override
  String get collection => 'Collection';

  @override
  String get newCollection => 'New Collection';

  @override
  String get collectionName => 'Collection Name';

  @override
  String get collectionDescription => 'Description';

  @override
  String get addToCollection => 'Add to Collection';

  @override
  String get removeFromCollection => 'Remove from Collection';

  @override
  String get collectionCreated => 'Collection created';

  @override
  String get collectionUpdated => 'Collection updated';

  @override
  String get collectionDeleted => 'Collection deleted';

  @override
  String get videoAddedToCollection => 'Video added to collection';

  @override
  String get videoRemovedFromCollection => 'Video removed from collection';

  @override
  String get noCollections => 'No collections yet';

  @override
  String get createFirstCollection => 'Create your first collection';

  @override
  String videosInCollection(int count) {
    return '$count videos';
  }

  @override
  String get advancedSearch => 'Advanced Search';

  @override
  String get filterBy => 'Filter By';

  @override
  String get sortBy => 'Sort By';

  @override
  String get sortNewest => 'Newest First';

  @override
  String get sortOldest => 'Oldest First';

  @override
  String get sortTitle => 'Title (A-Z)';

  @override
  String get sortPlatform => 'Platform';

  @override
  String get filterPlatform => 'Platform';

  @override
  String get filterCategory => 'Category';

  @override
  String get filterTags => 'Tags';

  @override
  String get filterDateRange => 'Date Range';

  @override
  String get fromDate => 'From Date';

  @override
  String get toDate => 'To Date';

  @override
  String get clearFilters => 'Clear Filters';

  @override
  String get applyFilters => 'Apply Filters';

  @override
  String get selectMultiple => 'Select Multiple';

  @override
  String get allPlatforms => 'All Platforms';

  @override
  String get detailedInformation => 'Detailed Information';

  @override
  String get linkDetails => 'Link Details';

  @override
  String get videoType => 'Video Type';

  @override
  String get urlLength => 'URL Length';

  @override
  String get fullUrl => 'Full URL';

  @override
  String get characters => 'characters';

  @override
  String get playInApp => 'Play in App';

  @override
  String get instagramInfo => 'Instagram Information';

  @override
  String get loadingInstagramInfo => 'Loading Instagram information...';

  @override
  String get author => 'Author';

  @override
  String get postType => 'Type';

  @override
  String get postId => 'Post ID';

  @override
  String get igtv => 'IGTV';

  @override
  String get twitterVideo => 'Twitter Video';

  @override
  String get video => 'Video';

  @override
  String couldNotOpen(String platform) {
    return 'Could not open $platform';
  }
}
