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
  String get allCategories => 'Tümü';

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
  String get theme => 'Tema';

  @override
  String get lightTheme => 'Açık Tema';

  @override
  String get darkTheme => 'Koyu Tema';

  @override
  String get systemTheme => 'Sistem Teması';

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
  String get appVersion => 'Uygulama Sürümü';

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
}
