// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Linkcim';

  @override
  String get home => 'Startseite';

  @override
  String get addVideo => 'Video hinzufügen';

  @override
  String get editVideo => 'Video bearbeiten';

  @override
  String get search => 'Suchen';

  @override
  String get settings => 'Einstellungen';

  @override
  String get videoTitle => 'Videotitel';

  @override
  String get videoDescription => 'Videobeschreibung';

  @override
  String get category => 'Kategorie';

  @override
  String get tags => 'Schlagwörter';

  @override
  String get save => 'Speichern';

  @override
  String get update => 'Aktualisieren';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get delete => 'Löschen';

  @override
  String get edit => 'Bearbeiten';

  @override
  String get noVideos => 'Noch keine Videos hinzugefügt';

  @override
  String get addFirstVideo => 'Fügen Sie Ihr erstes Video hinzu';

  @override
  String get allCategories => 'Alle Kategorien';

  @override
  String get videoUrl => 'Video-URL';

  @override
  String get enterVideoUrl => 'Video-URL eingeben';

  @override
  String get invalidUrl => 'Bitte geben Sie eine gültige Video-URL ein';

  @override
  String get required => 'Erforderlich';

  @override
  String get optional => 'Optional';

  @override
  String get language => 'Sprache';

  @override
  String get turkish => 'Türkisch';

  @override
  String get english => 'Englisch';

  @override
  String get german => 'Deutsch';

  @override
  String get russian => 'Russisch';

  @override
  String get french => 'Französisch';

  @override
  String get chinese => 'Chinesisch';

  @override
  String get theme => 'Design';

  @override
  String get lightTheme => 'Hell';

  @override
  String get darkTheme => 'Dunkel';

  @override
  String get systemTheme => 'System';

  @override
  String get colorScheme => 'Farbschema';

  @override
  String get permissions => 'Berechtigungen';

  @override
  String get storagePermissions => 'Speicher-Berechtigungen';

  @override
  String get managePermissions => 'Berechtigungen verwalten';

  @override
  String get systemSettings => 'Systemeinstellungen';

  @override
  String get dataManagement => 'Datenverwaltung';

  @override
  String get clearAllData => 'Alle Daten löschen';

  @override
  String get clearDataWarning =>
      'Diese Aktion löscht alle Ihre Videos und kann nicht rückgängig gemacht werden. Möchten Sie fortfahren?';

  @override
  String get about => 'Über';

  @override
  String get appInfo =>
      'Intelligente Video-Aufnahme- und Kategorisierungsanwendung';

  @override
  String get addTag => 'Tag hinzufügen';

  @override
  String get enterTag => 'Tag eingeben und Enter drücken';

  @override
  String get newVideo => 'Neues Video';

  @override
  String get editVideoInfo => 'Videoinformationen bearbeiten';

  @override
  String get videoInfoDescription =>
      'Geben Sie Videoinformationen ein und fügen Sie sie zu Ihrer Sammlung hinzu';

  @override
  String get selectCategory => 'Videokategorie auswählen';

  @override
  String get videoSaved => 'Video erfolgreich gespeichert';

  @override
  String get videoUpdated => 'Video aktualisiert';

  @override
  String get saveError => 'Speicherfehler';

  @override
  String get allPermissionsGranted => 'Alle Berechtigungen erteilt';

  @override
  String get permissionsMissing => 'Berechtigungen fehlen';

  @override
  String get permissionInfo =>
      'Die Linkcim-App erfordert die folgenden Berechtigungen:';

  @override
  String get storageAccess => 'Speicherzugriff';

  @override
  String get storageAccessDesc => 'Zum Zugriff auf App-Daten';

  @override
  String get videoMediaAccess => 'Video/Medien-Zugriff';

  @override
  String get videoMediaAccessDesc => 'Zum Zugriff auf Videodateien';

  @override
  String get fileManagement => 'Dateiverwaltung';

  @override
  String get fileManagementDesc => 'Zum Organisieren von Videodateien';

  @override
  String get dataPrivacy =>
      'Ihre Daten sind sicher und werden nur für die App-Funktionalität verwendet.';

  @override
  String get requestingPermissions => 'Berechtigungen anfordern...';

  @override
  String get permissionsGranted => 'Alle Berechtigungen erteilt!';

  @override
  String get permissionsDenied => 'Einige Berechtigungen wurden verweigert.';

  @override
  String get dataCleared => 'Alle Daten gelöscht';

  @override
  String get clearDataError => 'Fehler beim Löschen der Daten';

  @override
  String get appVersion => 'Anwendungsversion';

  @override
  String get developedWith => 'Entwickelt mit Flutter.';

  @override
  String get searchVideos => 'Suchen Sie Ihre Videos...';

  @override
  String get videosLoading => 'Videos werden geladen...';

  @override
  String get noVideoFound => 'Kein Video gefunden';

  @override
  String get tryDifferentKeywords => 'Versuchen Sie andere Schlüsselwörter.';

  @override
  String get addFirstVideoButton => 'Fügen Sie Ihr erstes Video hinzu';

  @override
  String get videoDelete => 'Video löschen';

  @override
  String get confirmDelete => 'Möchten Sie dieses Video wirklich löschen?';

  @override
  String get videoDeleted => 'Video gelöscht';

  @override
  String get videoDeleteError => 'Video konnte nicht gelöscht werden';

  @override
  String get dataLoadError => 'Fehler beim Laden der Daten';

  @override
  String get videoUrlRequired => 'Video-URL ist erforderlich';

  @override
  String get titleRequired => 'Titel ist erforderlich';

  @override
  String get categoryRequired => 'Kategorie ist erforderlich';

  @override
  String get enterTitle => 'Videotitel eingeben';

  @override
  String get enterDescription =>
      'Schreiben Sie eine Beschreibung über das Video (optional)';

  @override
  String tagsCount(int count) {
    return 'Schlagwörter ($count/10)';
  }

  @override
  String get videoSearch => 'Video-Suche';

  @override
  String get searchPlaceholder =>
      'Videos suchen... (Titel, Autor, Plattform, Tag)';

  @override
  String get clearSearch => 'Suche löschen';

  @override
  String videosFound(int count) {
    return '$count Videos gefunden';
  }

  @override
  String get searchError => 'Suchfehler';

  @override
  String get noVideoMatch =>
      'Kein Video gefunden, das Ihren Suchkriterien entspricht.\nVersuchen Sie andere Schlüsselwörter.';

  @override
  String get videoStatistics => 'Video-Statistiken';

  @override
  String get totalVideos => 'Gesamt Videos';

  @override
  String get categories => 'Kategorien';

  @override
  String get platformDistribution => 'Plattform-Verteilung';

  @override
  String get popularCategories => 'Beliebte Kategorien';

  @override
  String get refresh => 'Aktualisieren';

  @override
  String get share => 'Teilen';

  @override
  String get preview => 'Vorschau';

  @override
  String get open => 'Öffnen';

  @override
  String get openInPlatform => 'Auf Plattform öffnen';

  @override
  String get openInInstagram => 'Auf Instagram öffnen';

  @override
  String get openInYouTube => 'Auf YouTube öffnen';

  @override
  String get openInTikTok => 'Auf TikTok öffnen';

  @override
  String get openInTwitter => 'Auf Twitter öffnen';

  @override
  String get videoInfo => 'Videoinformationen';

  @override
  String get duration => 'Dauer';

  @override
  String get resolution => 'Auflösung';

  @override
  String get fileSize => 'Dateigröße';

  @override
  String get filePath => 'Dateipfad';

  @override
  String get calculating => 'Berechne...';

  @override
  String get videoLoading => 'Video wird geladen...';

  @override
  String get videoCannotPlay => 'Video kann nicht abgespielt werden';

  @override
  String get retry => 'Wiederholen';

  @override
  String get goBack => 'Zurück';

  @override
  String get unknownError => 'Ein unbekannter Fehler ist aufgetreten';

  @override
  String get videoFileNotFound => 'Videodatei nicht gefunden';

  @override
  String get videoFileEmpty =>
      'Videodatei ist leer oder kann nicht gelesen werden';

  @override
  String get videoLoadTimeout => 'Video-Ladezeit überschritten';

  @override
  String get videoFormatNotSupported => 'Videoformat wird nicht unterstützt';

  @override
  String get noPermission =>
      'Keine Berechtigung zum Zugriff auf die Videodatei';

  @override
  String get videoPlayError => 'Video kann nicht abgespielt werden';

  @override
  String get linkOpenError => 'Link-Öffnungsfehler';

  @override
  String get platformCannotOpen => 'kann nicht geöffnet werden';

  @override
  String get organizeVideos =>
      'Organisieren Sie Ihre Videos und finden Sie sie leicht.';

  @override
  String get manualEditPermissions => 'App-Berechtigungen manuell bearbeiten';

  @override
  String get checkingPermissions => 'Berechtigungen prüfen...';

  @override
  String get permissionRequestError => 'Berechtigungsanfragefehler';

  @override
  String get iosAutoPermission =>
      'Automatische Berechtigung auf iOS-Geräten erteilt';

  @override
  String get carefulUse =>
      'Vorsichtig verwenden - kann nicht rückgängig gemacht werden';

  @override
  String get appInformation => 'Anwendungsinformationen';

  @override
  String get searchPlaceholderShort => 'Suchen...';

  @override
  String get shareVideoLink => 'Video-Link teilen';

  @override
  String get shareVideoLinkDesc => 'Über Telefon-Teilmenü';

  @override
  String get shareDetailedInfo => 'Detaillierte Informationen teilen';

  @override
  String get shareDetailedInfoDesc => 'Mit Titel, Beschreibung und Tags';

  @override
  String get copyLink => 'Link kopieren';

  @override
  String get copyLinkDesc => 'In Zwischenablage kopieren';

  @override
  String get linkCopied => 'Link in Zwischenablage kopiert';

  @override
  String get shareError => 'Teilfehler';

  @override
  String get copyError => 'Kopierfehler';

  @override
  String get videoLinkShared => 'Video-Link geteilt';

  @override
  String get videoDetailsShared => 'Video-Details geteilt';

  @override
  String get loading => 'Laden...';

  @override
  String get previewLoading => 'Vorschau\nLaden...';

  @override
  String get previewUnavailable => 'Vorschau\nNicht verfügbar';

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
  String get platformGeneral => 'Allgemein';

  @override
  String get categoryGeneral => 'Allgemein';

  @override
  String get categorySoftware => 'Software';

  @override
  String get categoryEducation => 'Bildung';

  @override
  String get categoryEntertainment => 'Unterhaltung';

  @override
  String get categorySports => 'Sport';

  @override
  String get categoryFood => 'Essen';

  @override
  String get categoryMusic => 'Musik';

  @override
  String get categoryArt => 'Kunst';

  @override
  String get categoryScience => 'Wissenschaft';

  @override
  String get categoryTechnology => 'Technologie';

  @override
  String get noDescription => 'Keine Beschreibung';

  @override
  String get descriptionNotAvailable => 'Beschreibung nicht verfügbar';

  @override
  String get noTags => 'Keine Tags';

  @override
  String get sharedFromLinkcim => 'Von Linkcim-App geteilt';

  @override
  String videoCollection(int count) {
    return 'Video-Sammlung ($count Videos)';
  }

  @override
  String categoryVideos(String category) {
    return '$category Kategorie';
  }

  @override
  String videosFoundInCategory(int count) {
    return '$count Videos gefunden';
  }

  @override
  String andMoreVideos(int count) {
    return '... und $count weitere Videos';
  }

  @override
  String get videoTitleFromUrl => 'Videotitel';

  @override
  String get instagramPost => 'Instagram-Beitrag';

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
  String get tiktokVideoShortLink => 'TikTok Video (Kurzer Link)';

  @override
  String get twitterPost => 'Twitter-Beitrag';

  @override
  String twitterUser(String username) {
    return 'Twitter (@$username)';
  }

  @override
  String get xTwitterPost => 'X/Twitter-Beitrag';

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
  String get unknownChannel => 'Unbekannter Kanal';

  @override
  String get quickShare => 'Schnell teilen';

  @override
  String get videoShared => 'Video geteilt';

  @override
  String shareFailed(String error) {
    return 'Teilen fehlgeschlagen: $error';
  }

  @override
  String get grantPermission => 'Berechtigung erteilen';

  @override
  String get later => 'Später';

  @override
  String get videoAccess => 'Videozugriff';

  @override
  String get videoAccessDescription =>
      'Zum Speichern und Organisieren von Video-Links';

  @override
  String get collections => 'Sammlungen';

  @override
  String get collection => 'Sammlung';

  @override
  String get newCollection => 'Neue Sammlung';

  @override
  String get collectionName => 'Sammlungsname';

  @override
  String get collectionDescription => 'Beschreibung';

  @override
  String get addToCollection => 'Zur Sammlung hinzufügen';

  @override
  String get removeFromCollection => 'Aus Sammlung entfernen';

  @override
  String get collectionCreated => 'Sammlung erstellt';

  @override
  String get collectionUpdated => 'Sammlung aktualisiert';

  @override
  String get collectionDeleted => 'Sammlung gelöscht';

  @override
  String get videoAddedToCollection => 'Video zur Sammlung hinzugefügt';

  @override
  String get videoRemovedFromCollection => 'Video aus Sammlung entfernt';

  @override
  String get noCollections => 'Noch keine Sammlungen';

  @override
  String get createFirstCollection => 'Erstellen Sie Ihre erste Sammlung';

  @override
  String videosInCollection(int count) {
    return '$count Videos';
  }

  @override
  String get advancedSearch => 'Erweiterte Suche';

  @override
  String get filterBy => 'Filtern nach';

  @override
  String get sortBy => 'Sortieren nach';

  @override
  String get sortNewest => 'Neueste zuerst';

  @override
  String get sortOldest => 'Älteste zuerst';

  @override
  String get sortTitle => 'Titel (A-Z)';

  @override
  String get sortPlatform => 'Plattform';

  @override
  String get filterPlatform => 'Plattform';

  @override
  String get filterCategory => 'Kategorie';

  @override
  String get filterTags => 'Schlagwörter';

  @override
  String get filterDateRange => 'Datumsbereich';

  @override
  String get fromDate => 'Von Datum';

  @override
  String get toDate => 'Bis Datum';

  @override
  String get clearFilters => 'Filter löschen';

  @override
  String get applyFilters => 'Filter anwenden';

  @override
  String get selectMultiple => 'Mehrfach auswählen';

  @override
  String get allPlatforms => 'Alle Plattformen';

  @override
  String get detailedInformation => 'Detaillierte Informationen';

  @override
  String get linkDetails => 'Link-Details';

  @override
  String get videoType => 'Videotyp';

  @override
  String get urlLength => 'URL-Länge';

  @override
  String get fullUrl => 'Vollständige URL';

  @override
  String get characters => 'Zeichen';

  @override
  String get playInApp => 'In App abspielen';

  @override
  String get instagramInfo => 'Instagram-Informationen';

  @override
  String get loadingInstagramInfo =>
      'Instagram-Informationen werden geladen...';

  @override
  String get author => 'Autor';

  @override
  String get postType => 'Typ';

  @override
  String get postId => 'Beitrags-ID';

  @override
  String get igtv => 'IGTV';

  @override
  String get twitterVideo => 'Twitter Video';

  @override
  String get video => 'Video';

  @override
  String couldNotOpen(String platform) {
    return '$platform konnte nicht geöffnet werden';
  }

  @override
  String get platform => 'Plattform';

  @override
  String get appDescription =>
      'Video-Organisations-App. Organisieren Sie Videos von Instagram, YouTube, TikTok und Twitter.';

  @override
  String get technicalInformation => 'Technische Informationen';

  @override
  String get framework => 'Framework';

  @override
  String get systemVersion => 'Systemversion';

  @override
  String get packageName => 'Paketname';

  @override
  String get developer => 'Entwickler';

  @override
  String get developerName => 'Entwickler';

  @override
  String get profession => 'Beruf';

  @override
  String get visitWebsite => 'Besuchen Sie meine Website';

  @override
  String get close => 'Schließen';

  @override
  String get computerEngineer => 'Informatiker';
}
