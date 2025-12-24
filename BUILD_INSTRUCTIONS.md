# 🚀 Release Build Talimatları

## 1. key.properties Dosyasını Doldurun

`android/key.properties` dosyasını açın ve şifrelerinizi yazın:

```properties
storePassword=KEŞTORE_ŞİFRESİ
keyPassword=KEY_ŞİFRESİ
keyAlias=upload
storeFile=upload-keystore.jks
```

## 2. Release Build Oluşturun

### App Bundle (AAB) - Play Store için (ÖNERİLEN):

```bash
flutter build appbundle --release
```

Oluşturulan dosya: `build/app/outputs/bundle/release/app-release.aab`

### APK - Test için:

```bash
flutter build apk --release
```

Oluşturulan dosya: `build/app/outputs/flutter-apk/app-release.apk`

## 3. Build Hatalarını Kontrol Edin

Eğer build hatası alırsanız:

```bash
# Temizlik yapın
flutter clean
flutter pub get

# Tekrar build edin
flutter build appbundle --release
```

## 4. Keystore Bilgilerini Kontrol Edin

Eğer "keystore not found" hatası alırsanız:
- `upload-keystore.jks` dosyasının `android/` klasöründe olduğundan emin olun
- `key.properties` dosyasındaki `storeFile` yolunun doğru olduğundan emin olun
- Şifrelerin doğru olduğundan emin olun

## 5. Build Başarılı Olduysa

✅ AAB dosyasını Play Store Console'a yükleyebilirsiniz!
✅ `PLAY_STORE_RELEASE_GUIDE.md` dosyasındaki adımları takip edin

