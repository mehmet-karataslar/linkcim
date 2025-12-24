# ✅ Play Store Yayınlama Kontrol Listesi

Bu kontrol listesi, uygulamanızı Play Store'a yüklemeden önce yapmanız gerekenleri içerir.

## 🔐 1. Keystore ve İmzalama

- [ ] Keystore dosyası oluşturuldu (`upload-keystore.jks`)
- [ ] `key.properties` dosyası oluşturuldu ve dolduruldu
- [ ] Keystore şifreleri güvenli bir yerde yedeklendi
- [ ] `build.gradle.kts` dosyası keystore kullanacak şekilde yapılandırıldı
- [ ] Release build test edildi ve çalışıyor

## 📱 2. Uygulama Yapılandırması

- [ ] `applicationId` doğru: `com.linkcim.linkcim`
- [ ] `versionCode` ve `versionName` doğru (pubspec.yaml: `1.0.0+1`)
- [ ] `minSdk` 21 veya üzeri
- [ ] `targetSdk` 34 (güncel Play Store gereksinimi)
- [ ] App label düzeltildi: "Linkcim"
- [ ] ProGuard/R8 kuralları eklendi

## 🎨 3. Görseller ve İçerik

- [ ] **App Icon:** 512x512 px PNG hazır
- [ ] **Feature Graphic:** 1024x500 px hazır
- [ ] **Screenshots:** En az 2 adet telefon screenshot'ı
- [ ] **Tablet Screenshots:** (Opsiyonel ama önerilir)
- [ ] Uygulama açıklaması hazır (Türkçe ve İngilizce)
- [ ] Kısa açıklama hazır (80 karakter)

## 📄 4. Yasal Gereksinimler

- [ ] **Gizlilik Politikası** hazır ve yayınlandı (URL mevcut)
- [ ] İçerik derecelendirme anketi dolduruldu
- [ ] İzin açıklamaları hazır (Play Store'da her izin için)

## 🔒 5. İzinler ve Güvenlik

- [ ] AndroidManifest.xml'deki izinler kontrol edildi
- [ ] Her izin için Play Store'da açıklama hazır:
  - [ ] INTERNET - Video indirme ve API çağrıları için
  - [ ] ACCESS_NETWORK_STATE - Ağ durumu kontrolü için
  - [ ] READ_EXTERNAL_STORAGE - Android 12 ve altı için
  - [ ] WRITE_EXTERNAL_STORAGE - Android 10 ve altı için
  - [ ] READ_MEDIA_VIDEO - Android 13+ için video erişimi
- [ ] API anahtarları güvenli (api_config.dart .gitignore'da)

## 🧪 6. Test ve Kalite

- [ ] Release build test edildi (`flutter build appbundle --release`)
- [ ] Uygulama farklı cihazlarda test edildi
- [ ] Tüm özellikler çalışıyor
- [ ] Crash veya hata yok
- [ ] Performans test edildi

## 📦 7. Build ve Yükleme

- [ ] AAB dosyası oluşturuldu (`app-release.aab`)
- [ ] AAB dosyası test edildi (Google Play Console'da internal testing)
- [ ] Release notları hazır
- [ ] Tüm bilgiler Play Store Console'da dolduruldu

## 📋 8. Play Store Console Bilgileri

- [ ] Uygulama adı: Linkcim
- [ ] Kategori seçildi (Productivity veya Entertainment)
- [ ] İletişim bilgileri eklendi
- [ ] Gizlilik politikası URL'si eklendi
- [ ] İçerik derecelendirmesi tamamlandı
- [ ] Fiyatlandırma ayarlandı (Ücretsiz)

## 🚀 9. Yayınlama

- [ ] Tüm bilgiler kontrol edildi
- [ ] Internal testing'de test edildi
- [ ] Production'a gönderildi
- [ ] Google incelemesi bekleniyor (1-3 gün)

## 📝 10. Yayınlama Sonrası

- [ ] Uygulama yayınlandıktan sonra test edildi
- [ ] Kullanıcı geri bildirimleri takip ediliyor
- [ ] Güncelleme planı hazır (versionCode artırılacak)

---

## ⚠️ Önemli Hatırlatmalar

1. **Keystore'u kaybetmeyin!** Yedekleyin ve güvenli bir yerde saklayın.
2. **İlk yayınlama 1-3 gün sürebilir** - Google incelemesi gerekir.
3. **Her güncellemede versionCode artırın** (pubspec.yaml'da `+1` → `+2`).
4. **Gizlilik politikası URL'si zorunludur** - GitHub Pages veya kendi web sitenizde yayınlayın.

---

**Hazır olduğunuzda `PLAY_STORE_RELEASE_GUIDE.md` dosyasındaki adımları takip edin!**

