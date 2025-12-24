// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'Linkcim';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get addVideo => 'Video Ekle';

  @override
  String get editVideo => 'Video Düzenle';

  @override
  String get search => 'Ara';

  @override
  String get settings => 'Ayarlar';

  @override
  String get videoTitle => 'Video Başlığı';

  @override
  String get videoDescription => 'Video Açıklaması';

  @override
  String get category => 'Kategori';

  @override
  String get tags => 'Etiketler';

  @override
  String get save => 'Kaydet';

  @override
  String get update => 'Güncelle';

  @override
  String get cancel => 'İptal';

  @override
  String get delete => 'Sil';

  @override
  String get edit => 'Düzenle';

  @override
  String get noVideos => 'Henüz video eklenmedi';

  @override
  String get addFirstVideo => 'İlk videonuzu ekleyin';

  @override
  String get allCategories => 'Tüm Kategoriler';

  @override
  String get videoUrl => 'Video Linki';

  @override
  String get enterVideoUrl => 'Video linkini girin';

  @override
  String get invalidUrl => 'Geçerli bir video linki giriniz';

  @override
  String get required => 'Gerekli';

  @override
  String get optional => 'İsteğe bağlı';

  @override
  String get language => 'Dil';

  @override
  String get turkish => 'Türkçe';

  @override
  String get english => 'İngilizce';

  @override
  String get german => 'Almanca';

  @override
  String get russian => 'Rusça';

  @override
  String get french => 'Fransızca';

  @override
  String get theme => 'Tema';

  @override
  String get lightTheme => 'Açık Tema';

  @override
  String get darkTheme => 'Koyu Tema';

  @override
  String get systemTheme => 'Sistem Teması';

  @override
  String get colorScheme => 'Renk Şeması';

  @override
  String get permissions => 'İzinler';

  @override
  String get storagePermissions => 'Depolama İzinleri';

  @override
  String get managePermissions => 'İzinleri Yönet';

  @override
  String get systemSettings => 'Sistem Ayarları';

  @override
  String get dataManagement => 'Veri Yönetimi';

  @override
  String get clearAllData => 'Tüm Verileri Sil';

  @override
  String get clearDataWarning =>
      'Bu işlem tüm videolarınızı silecektir ve geri alınamaz. Devam etmek istediğinizden emin misiniz?';

  @override
  String get about => 'Hakkında';

  @override
  String get appInfo => 'Akıllı Video Kayıt ve Kategorilendirme Uygulaması';

  @override
  String get addTag => 'Etiket Ekle';

  @override
  String get enterTag => 'Etiket yazın ve Enter\'a basın';

  @override
  String get newVideo => 'Yeni Video';

  @override
  String get editVideoInfo => 'Video Bilgilerini Düzenle';

  @override
  String get videoInfoDescription =>
      'Video bilgilerini girin ve koleksiyonunuza ekleyin';

  @override
  String get selectCategory => 'Video kategorisini seçin';

  @override
  String get videoSaved => 'Video başarıyla kaydedildi';

  @override
  String get videoUpdated => 'Video güncellendi';

  @override
  String get saveError => 'Kayıt hatası';

  @override
  String get allPermissionsGranted => 'Tüm izinler verildi';

  @override
  String get permissionsMissing => 'İzinler eksik';

  @override
  String get permissionInfo =>
      'Linkcim uygulaması aşağıdaki izinlere ihtiyaç duyar:';

  @override
  String get storageAccess => 'Depolama Erişimi';

  @override
  String get storageAccessDesc => 'Uygulama verilerine erişmek için';

  @override
  String get videoMediaAccess => 'Video/Medya Erişimi';

  @override
  String get videoMediaAccessDesc => 'Video dosyalarına erişmek için';

  @override
  String get fileManagement => 'Dosya Yönetimi';

  @override
  String get fileManagementDesc => 'Video dosyalarını organize etmek için';

  @override
  String get dataPrivacy =>
      'Verileriniz güvende, sadece uygulama işlevselliği için kullanılır.';

  @override
  String get requestingPermissions => 'İzinler isteniyor...';

  @override
  String get permissionsGranted => 'Tüm izinler verildi!';

  @override
  String get permissionsDenied => 'Bazı izinler reddedildi.';

  @override
  String get dataCleared => 'Tüm veriler silindi';

  @override
  String get clearDataError => 'Veri silinirken hata oluştu';

  @override
  String get appVersion => 'Uygulama Versiyonu';

  @override
  String get developedWith => 'Flutter ile geliştirilmiştir.';

  @override
  String get searchVideos => 'Videolarınızı arayın...';

  @override
  String get videosLoading => 'Videolar yükleniyor...';

  @override
  String get noVideoFound => 'Video bulunamadı';

  @override
  String get tryDifferentKeywords => 'Farklı anahtar kelimeler deneyin.';

  @override
  String get addFirstVideoButton => 'İlk Videonuzu Ekleyin';

  @override
  String get videoDelete => 'Video Sil';

  @override
  String get confirmDelete => 'Bu videoyu silmek istediğinizden emin misiniz?';

  @override
  String get videoDeleted => 'Video silindi';

  @override
  String get videoDeleteError => 'Video silinemedi';

  @override
  String get dataLoadError => 'Veriler yüklenirken hata oluştu';

  @override
  String get videoUrlRequired => 'Video linki gerekli';

  @override
  String get titleRequired => 'Başlık gerekli';

  @override
  String get categoryRequired => 'Kategori gerekli';

  @override
  String get enterTitle => 'Video başlığını girin';

  @override
  String get enterDescription => 'Video hakkında açıklama yazın (isteğe bağlı)';

  @override
  String tagsCount(int count) {
    return 'Etiketler ($count/10)';
  }

  @override
  String get videoSearch => 'Video Arama';

  @override
  String get searchPlaceholder =>
      'Video ara... (başlık, yazar, platform, etiket)';

  @override
  String get clearSearch => 'Aramayı Temizle';

  @override
  String videosFound(int count) {
    return '$count video bulundu';
  }

  @override
  String get searchError => 'Arama hatası';

  @override
  String get noVideoMatch =>
      'Arama kriterinize uygun video bulunamadı.\nFarklı anahtar kelimeler deneyin.';

  @override
  String get videoStatistics => 'Video İstatistikleri';

  @override
  String get totalVideos => 'Toplam Video';

  @override
  String get categories => 'Kategoriler';

  @override
  String get platformDistribution => 'Platform Dağılımı';

  @override
  String get popularCategories => 'Popüler Kategoriler';

  @override
  String get refresh => 'Yenile';

  @override
  String get share => 'Paylaş';

  @override
  String get preview => 'Önizleme';

  @override
  String get open => 'Aç';

  @override
  String get openInPlatform => 'Platformda Aç';

  @override
  String get openInInstagram => 'Instagram\'da Aç';

  @override
  String get openInYouTube => 'YouTube\'de Aç';

  @override
  String get openInTikTok => 'TikTok\'ta Aç';

  @override
  String get openInTwitter => 'Twitter\'da Aç';

  @override
  String get videoInfo => 'Video Bilgileri';

  @override
  String get duration => 'Süre';

  @override
  String get resolution => 'Çözünürlük';

  @override
  String get fileSize => 'Dosya Boyutu';

  @override
  String get filePath => 'Dosya Yolu';

  @override
  String get calculating => 'Hesaplanıyor...';

  @override
  String get videoLoading => 'Video yükleniyor...';

  @override
  String get videoCannotPlay => 'Video Oynatılamadı';

  @override
  String get retry => 'Tekrar Dene';

  @override
  String get goBack => 'Geri Dön';

  @override
  String get unknownError => 'Bilinmeyen bir hata oluştu';

  @override
  String get videoFileNotFound => 'Video dosyası bulunamadı';

  @override
  String get videoFileEmpty => 'Video dosyası boş veya okunamıyor';

  @override
  String get videoLoadTimeout => 'Video yükleme zaman aşımına uğradı';

  @override
  String get videoFormatNotSupported => 'Video formatı desteklenmiyor';

  @override
  String get noPermission => 'Video dosyasına erişim izni yok';

  @override
  String get videoPlayError => 'Video oynatılamadı';

  @override
  String get linkOpenError => 'Link açma hatası';

  @override
  String get platformCannotOpen => 'açılamadı';

  @override
  String get organizeVideos => 'Videolarınızı organize edin ve kolayca bulun.';

  @override
  String get manualEditPermissions =>
      'Uygulama izinlerini manuel olarak düzenle';

  @override
  String get checkingPermissions => 'İzinler kontrol ediliyor...';

  @override
  String get permissionRequestError => 'İzin isteme hatası';

  @override
  String get iosAutoPermission => 'iOS cihazlarda otomatik izin verildi';

  @override
  String get carefulUse => 'Dikkatli kullanın - geri alınamaz';

  @override
  String get appInformation => 'Uygulama bilgileri';

  @override
  String get searchPlaceholderShort => 'Ara...';

  @override
  String get shareVideoLink => 'Video Linkini Paylaş';

  @override
  String get shareVideoLinkDesc => 'Telefonun paylaş menüsü ile';

  @override
  String get shareDetailedInfo => 'Detaylı Bilgi Paylaş';

  @override
  String get shareDetailedInfoDesc => 'Başlık, açıklama ve etiketlerle';

  @override
  String get copyLink => 'Linki Kopyala';

  @override
  String get copyLinkDesc => 'Panoya kopyala';

  @override
  String get linkCopied => 'Link panoya kopyalandı';

  @override
  String get shareError => 'Paylaşma hatası';

  @override
  String get copyError => 'Kopyalama hatası';

  @override
  String get videoLinkShared => 'Video linki paylaşıldı';

  @override
  String get videoDetailsShared => 'Video detayları paylaşıldı';

  @override
  String get loading => 'Yükleniyor...';

  @override
  String get previewLoading => 'Önizleme\nYükleniyor...';

  @override
  String get previewUnavailable => 'Önizleme\nUlaşılamıyor';

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
  String get platformGeneral => 'Genel';

  @override
  String get categoryGeneral => 'Genel';

  @override
  String get categorySoftware => 'Yazılım';

  @override
  String get categoryEducation => 'Eğitim';

  @override
  String get categoryEntertainment => 'Eğlence';

  @override
  String get categorySports => 'Spor';

  @override
  String get categoryFood => 'Yemek';

  @override
  String get categoryMusic => 'Müzik';

  @override
  String get categoryArt => 'Sanat';

  @override
  String get categoryScience => 'Bilim';

  @override
  String get categoryTechnology => 'Teknoloji';

  @override
  String get noDescription => 'Açıklama yok';

  @override
  String get descriptionNotAvailable => 'Açıklama mevcut değil';

  @override
  String get noTags => 'Etiket yok';

  @override
  String get sharedFromLinkcim => 'Linkcim uygulaması ile paylaşıldı';

  @override
  String videoCollection(int count) {
    return 'Video Koleksiyonu ($count video)';
  }

  @override
  String categoryVideos(String category) {
    return '$category Kategorisi';
  }

  @override
  String videosFoundInCategory(int count) {
    return '$count video bulundu';
  }

  @override
  String andMoreVideos(int count) {
    return '... ve $count video daha';
  }

  @override
  String get videoTitleFromUrl => 'Video Başlığı';

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
  String get tiktokVideoShortLink => 'TikTok Video (Kısa Link)';

  @override
  String get twitterPost => 'Twitter Gönderi';

  @override
  String twitterUser(String username) {
    return 'Twitter (@$username)';
  }

  @override
  String get xTwitterPost => 'X/Twitter Gönderi';

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
  String get unknownChannel => 'Bilinmeyen Kanal';

  @override
  String get quickShare => 'Hızlı Paylaş';

  @override
  String get videoShared => 'Video paylaşıldı';

  @override
  String shareFailed(String error) {
    return 'Paylaşma başarısız: $error';
  }

  @override
  String get grantPermission => 'İzin Ver';

  @override
  String get later => 'Sonra';

  @override
  String get videoAccess => 'Video Erişimi';

  @override
  String get videoAccessDescription =>
      'Video linklerini kaydetmek ve organize etmek için';

  @override
  String get collections => 'Koleksiyonlar';

  @override
  String get collection => 'Koleksiyon';

  @override
  String get newCollection => 'Yeni Koleksiyon';

  @override
  String get collectionName => 'Koleksiyon Adı';

  @override
  String get collectionDescription => 'Açıklama';

  @override
  String get addToCollection => 'Koleksiyona Ekle';

  @override
  String get removeFromCollection => 'Koleksiyondan Çıkar';

  @override
  String get collectionCreated => 'Koleksiyon oluşturuldu';

  @override
  String get collectionUpdated => 'Koleksiyon güncellendi';

  @override
  String get collectionDeleted => 'Koleksiyon silindi';

  @override
  String get videoAddedToCollection => 'Video koleksiyona eklendi';

  @override
  String get videoRemovedFromCollection => 'Video koleksiyondan çıkarıldı';

  @override
  String get noCollections => 'Henüz koleksiyon yok';

  @override
  String get createFirstCollection => 'İlk koleksiyonunuzu oluşturun';

  @override
  String videosInCollection(int count) {
    return '$count video';
  }

  @override
  String get advancedSearch => 'Gelişmiş Arama';

  @override
  String get filterBy => 'Filtrele';

  @override
  String get sortBy => 'Sırala';

  @override
  String get sortNewest => 'En Yeni';

  @override
  String get sortOldest => 'En Eski';

  @override
  String get sortTitle => 'Başlık (A-Z)';

  @override
  String get sortPlatform => 'Platform';

  @override
  String get filterPlatform => 'Platform';

  @override
  String get filterCategory => 'Kategori';

  @override
  String get filterTags => 'Etiketler';

  @override
  String get filterDateRange => 'Tarih Aralığı';

  @override
  String get fromDate => 'Başlangıç Tarihi';

  @override
  String get toDate => 'Bitiş Tarihi';

  @override
  String get clearFilters => 'Filtreleri Temizle';

  @override
  String get applyFilters => 'Filtreleri Uygula';

  @override
  String get selectMultiple => 'Çoklu Seçim';

  @override
  String get allPlatforms => 'Tüm Platformlar';

  @override
  String get detailedInformation => 'Detaylı Bilgiler';

  @override
  String get linkDetails => 'Link Detayları';

  @override
  String get videoType => 'Video Türü';

  @override
  String get urlLength => 'URL Uzunluğu';

  @override
  String get fullUrl => 'Tam URL';

  @override
  String get characters => 'karakter';

  @override
  String get playInApp => 'Uygulamada Oynat';

  @override
  String get instagramInfo => 'Instagram Bilgileri';

  @override
  String get loadingInstagramInfo => 'Instagram bilgileri yükleniyor...';

  @override
  String get author => 'Yazar';

  @override
  String get postType => 'Tip';

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
    return '$platform açılamadı';
  }

  @override
  String get platform => 'Platform';

  @override
  String get appDescription =>
      'Video organizasyon uygulaması. Instagram, YouTube, TikTok ve Twitter\'dan videoları organize edin.';

  @override
  String get technicalInformation => 'Teknik Bilgiler';

  @override
  String get framework => 'Framework';

  @override
  String get systemVersion => 'Sistem Versiyonu';

  @override
  String get packageName => 'Paket Adı';

  @override
  String get developer => 'Geliştirici';

  @override
  String get developerName => 'Geliştirici';

  @override
  String get profession => 'Meslek';

  @override
  String get visitWebsite => 'Web Sitemi Ziyaret Et';

  @override
  String get close => 'Kapat';

  @override
  String get computerEngineer => 'Bilgisayar Mühendisi';
}
