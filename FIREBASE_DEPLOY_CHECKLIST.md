# Firebase Analytics Deploy Kontrol Listesi

## ✅ Tamamlanan İşlemler

### 1. Firebase Konfigürasyon Dosyaları
- ✅ `android/app/google-services.json` - Mevcut ve doğru konumda
- ✅ `ios/Runner/GoogleService-Info.plist` - Mevcut ve doğru konumda

### 2. Paket Yükleme
- ✅ `firebase_core: ^3.6.0` - Eklendi
- ✅ `firebase_analytics: ^11.3.3` - Eklendi
- ✅ Paketler başarıyla yüklendi (`flutter pub get`)

### 3. Android Konfigürasyonu
- ✅ `android/build.gradle.kts` - Google Services classpath eklendi
- ✅ `android/app/build.gradle.kts` - Google Services plugin eklendi
- ✅ `google-services.json` doğru konumda

### 4. iOS Konfigürasyonu
- ✅ `GoogleService-Info.plist` doğru konumda (ios/Runner/)
- ✅ Flutter otomatik olarak iOS pod'ları yönetir

### 5. Flutter Kod Entegrasyonu
- ✅ `lib/main.dart` - Firebase başlatma kodu eklendi
- ✅ `lib/services/analytics_service.dart` - Analytics servisi oluşturuldu
- ✅ Tüm sayfalara analytics entegrasyonu yapıldı:
  - Ana sayfa (home_screen.dart)
  - Ayarlar sayfası (settings_screen.dart)
  - Video ekleme sayfası (add_video_screen.dart)
  - Arama sayfası (search_screen.dart)
  - Gelişmiş arama (advanced_search_screen.dart)
  - Koleksiyonlar (collections_screen.dart)
  - Video önizleme (video_preview_screen.dart)
  - Video kart widget (video_card.dart)

## 📋 Deploy Öncesi Kontroller

### Android
1. ✅ Google Services JSON dosyası doğru konumda
2. ✅ Build.gradle dosyaları güncellendi
3. ⚠️ Release keystore kontrolü (key.properties dosyası mevcut mu?)

### iOS
1. ✅ GoogleService-Info.plist doğru konumda
2. ⚠️ Xcode'da GoogleService-Info.plist'in projeye eklendiğinden emin olun
3. ⚠️ iOS için pod install gerekebilir (Flutter genelde otomatik yapar)

## 🚀 Deploy Adımları

### Android Deploy

```bash
# 1. Temizlik
flutter clean

# 2. Paketleri yükle
flutter pub get

# 3. Android build (Debug)
flutter build apk --debug

# 4. Android build (Release - Play Store için)
flutter build appbundle --release
# veya
flutter build apk --release
```

### iOS Deploy

```bash
# 1. Temizlik
flutter clean

# 2. Paketleri yükle
flutter pub get

# 3. iOS pod'larını yükle (gerekirse)
cd ios
pod install
cd ..

# 4. iOS build
flutter build ios --release
```

## 🔍 Firebase Console Kontrolü

Deploy sonrası Firebase Console'da kontrol edin:

1. **Firebase Console'a gidin**: https://console.firebase.google.com/
2. **Projenizi seçin**: `linkcim-1`
3. **Analytics** bölümüne gidin
4. **Events** sekmesinde şu olayları görmelisiniz:
   - `screen_view` - Sayfa görüntülemeleri
   - `button_click` - Buton tıklamaları
   - `video_added` - Video ekleme
   - `video_deleted` - Video silme
   - `video_played` - Video oynatma
   - `category_selected` - Kategori seçimi
   - `search` - Arama işlemleri
   - `collection_created` - Koleksiyon oluşturma
   - `theme_changed` - Tema değişikliği
   - `language_changed` - Dil değişikliği

## 📊 Takip Edilen Metrikler

### Sayfa Görüntülemeleri
- `home_screen` - Ana sayfa
- `settings_screen` - Ayarlar
- `add_video_screen` - Video ekleme
- `edit_video_screen` - Video düzenleme
- `search_screen` - Arama
- `advanced_search_screen` - Gelişmiş arama
- `collections_screen` - Koleksiyonlar
- `video_preview_screen` - Video önizleme

### Buton Tıklamaları
- `collections_button` - Koleksiyonlar butonu
- `advanced_search_button` - Gelişmiş arama butonu
- `search_button` - Arama butonu
- `settings_button` - Ayarlar butonu
- `add_video_fab` - Video ekleme FAB
- `video_preview` - Video önizleme
- `open_in_platform` - Platform'da aç
- `open_video_player` - Video oynatıcı aç
- Ve daha fazlası...

### Özel Olaylar
- Video ekleme/silme/güncelleme
- Kategori seçimleri
- Arama sorguları
- Koleksiyon oluşturma
- Tema ve dil değişiklikleri

## ⚠️ Önemli Notlar

1. **İlk Veriler**: Firebase Analytics'te verilerin görünmesi 24-48 saat sürebilir
2. **Debug Mode**: Debug modda test ederken Firebase Console'da "DebugView" kullanabilirsiniz
3. **Privacy**: Kullanıcı gizliliği için gerekli izinleri aldığınızdan emin olun
4. **GDPR**: Avrupa kullanıcıları için GDPR uyumluluğu gerekebilir

## 🐛 Sorun Giderme

### Android
- **Google Services hatası**: `google-services.json` dosyasının doğru konumda olduğundan emin olun
- **Build hatası**: `flutter clean` ve `flutter pub get` yapın

### iOS
- **Pod hatası**: `cd ios && pod install && cd ..` komutunu çalıştırın
- **GoogleService-Info.plist hatası**: Xcode'da dosyanın projeye eklendiğini kontrol edin

### Firebase
- **Veri görünmüyor**: 24-48 saat bekleyin veya DebugView kullanın
- **Events görünmüyor**: Uygulamanın internet bağlantısı olduğundan emin olun

## 📱 Test Etme

1. Uygulamayı çalıştırın
2. Farklı sayfalara gidin
3. Butonlara tıklayın
4. Video ekleyin/silin
5. Firebase Console'da DebugView'ı açın ve olayları kontrol edin

## ✅ Deploy Hazır!

Tüm konfigürasyonlar tamamlandı. Uygulamanızı build edip deploy edebilirsiniz!

