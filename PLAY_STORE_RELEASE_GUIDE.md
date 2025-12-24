# 📱 Play Store Yayınlama Rehberi - Linkcim

Bu rehber, Linkcim uygulamasını Google Play Store'a yüklemek için gerekli tüm adımları içerir.

## 🔐 1. Keystore Oluşturma (İLK ADIM - ÇOK ÖNEMLİ!)

Keystore dosyası, uygulamanızı imzalamak için kullanılır. **Bu dosyayı kaybetmeyin!** Kaybederseniz uygulamanızı güncelleyemezsiniz.

### Keystore Oluşturma Adımları:

1. **Terminal/Command Prompt'u açın** ve proje kök dizinine gidin:
   ```bash
   cd android
   ```

2. **Keystore oluşturun** (Windows için):
   ```bash
   keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

   **Mac/Linux için:**
   ```bash
   keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

3. **Soruları cevaplayın:**
   - Keystore şifresi: Güçlü bir şifre seçin ve **kaydedin!**
   - Key şifresi: Genellikle keystore şifresiyle aynı olabilir
   - İsim, organizasyon vb. bilgileri girin

4. **key.properties dosyası oluşturun:**
   - `android/key.properties.example` dosyasını kopyalayın
   - `android/key.properties` olarak kaydedin
   - Değerleri doldurun:
     ```properties
     storePassword=YOUR_KEYSTORE_PASSWORD
     keyPassword=YOUR_KEY_PASSWORD
     keyAlias=upload
     storeFile=../upload-keystore.jks
     ```

5. **Güvenlik:**
   - `key.properties` ve `upload-keystore.jks` dosyalarını **güvenli bir yerde yedekleyin**
   - Bu dosyalar `.gitignore`'da olduğu için Git'e yüklenmeyecek
   - **Keystore'u kaybetmeyin!** Kaybederseniz uygulamanızı güncelleyemezsiniz

## 🏗️ 2. Release APK/AAB Oluşturma

### App Bundle (AAB) Oluşturma (Önerilen - Play Store için):

```bash
flutter build appbundle --release
```

Oluşturulan dosya: `build/app/outputs/bundle/release/app-release.aab`

### APK Oluşturma (Test için):

```bash
flutter build apk --release
```

Oluşturulan dosya: `build/app/outputs/flutter-apk/app-release.apk`

## 📋 3. Play Store Console Hazırlıkları

### Gerekli Bilgiler:

1. **Uygulama Bilgileri:**
   - Uygulama Adı: Linkcim
   - Kısa Açıklama: Video organizasyon uygulaması
   - Tam Açıklama: (README.md'den alabilirsiniz)
   - Kategori: Productivity veya Entertainment

2. **Görseller:**
   - **App Icon:** 512x512 px (PNG, şeffaf olmayan)
   - **Feature Graphic:** 1024x500 px (Play Store'da gösterilir)
   - **Screenshots:** En az 2 adet, farklı ekran boyutları için:
     - Telefon: 16:9 veya 9:16, min 320px, max 3840px
     - Tablet: 16:9 veya 9:16, min 320px, max 3840px

3. **Gizlilik Politikası:**
   - Play Store, gizlilik politikası URL'si ister
   - Bir web sitesinde yayınlayın veya GitHub Pages kullanın
   - Örnek: `https://yourwebsite.com/privacy-policy` veya `https://yourusername.github.io/linkcim/privacy`

4. **İçerik Derecelendirmesi:**
   - PEGI, ESRB veya benzeri bir derecelendirme sistemi seçin
   - Uygulamanız video içeriği gösterdiği için uygun derecelendirme seçin

## 🔒 4. İzinler ve Açıklamalar

Uygulamanız şu izinleri kullanıyor:
- `INTERNET` - Video indirme ve API çağrıları için
- `ACCESS_NETWORK_STATE` - Ağ durumu kontrolü için
- `READ_EXTERNAL_STORAGE` - Android 12 ve altı için
- `WRITE_EXTERNAL_STORAGE` - Android 10 ve altı için
- `READ_MEDIA_VIDEO` - Android 13+ için video erişimi

**Play Store'da her izin için açıklama yapmanız gerekecek:**
- Neden bu izne ihtiyacınız var?
- Kullanıcı verileri nasıl korunuyor?

## 📝 5. Play Store Console'da Yayınlama

1. **Google Play Console'a giriş yapın:**
   - https://play.google.com/console

2. **Yeni Uygulama Oluşturun:**
   - "Uygulama oluştur" butonuna tıklayın
   - Uygulama adı: Linkcim
   - Varsayılan dil: Türkçe veya İngilizce
   - Uygulama türü: Uygulama
   - Ücretsiz mi ücretli mi: Ücretsiz

3. **Uygulama İçeriğini Doldurun:**
   - Açıklama
   - Görseller (icon, screenshots, feature graphic)
   - Kategori
   - İletişim bilgileri

4. **Gizlilik Politikası:**
   - Gizlilik politikası URL'sini ekleyin

5. **İçerik Derecelendirmesi:**
   - Anketi doldurun

6. **Uygulama Yükleme:**
   - "Production" veya "Internal testing" seçin
   - AAB dosyasını yükleyin (`app-release.aab`)
   - Release notları ekleyin

7. **İnceleme için Gönder:**
   - Tüm bilgileri kontrol edin
   - "İnceleme için gönder" butonuna tıklayın

## ⚠️ Önemli Notlar

### Keystore Güvenliği:
- **Keystore dosyasını ve şifresini güvenli bir yerde saklayın**
- Yedek kopyalar oluşturun
- Kaybederseniz uygulamanızı güncelleyemezsiniz!

### İlk Yayınlama:
- İlk yayınlama 1-3 gün sürebilir
- Google incelemesinden geçmesi gerekir
- Hata varsa düzeltip tekrar göndermeniz gerekir

### Güncellemeler:
- Her güncellemede `versionCode`'u artırın (pubspec.yaml'da)
- Örnek: `1.0.0+1` → `1.0.1+2`
- Yeni AAB oluşturup yükleyin

### Test:
- Önce "Internal testing" ile test edin
- Sonra "Production"a geçin

## 🐛 Sorun Giderme

### Build Hatası:
```bash
# Temizlik yapın
flutter clean
flutter pub get
flutter build appbundle --release
```

### Keystore Hatası:
- `key.properties` dosyasının doğru yolda olduğundan emin olun
- Şifrelerin doğru olduğundan emin olun
- Keystore dosyasının yolunun doğru olduğundan emin olun

### İzin Hatası:
- AndroidManifest.xml'deki izinlerin doğru olduğundan emin olun
- Play Store'da izin açıklamalarını ekleyin

## 📞 Destek

Sorun yaşarsanız:
- Flutter dokümantasyonu: https://flutter.dev/docs/deployment/android
- Play Store dokümantasyonu: https://support.google.com/googleplay/android-developer

---

**Başarılar! 🚀**

