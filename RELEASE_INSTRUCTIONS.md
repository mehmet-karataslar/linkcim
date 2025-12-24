# 📦 GitHub Release Oluşturma Talimatları

## APK Dosyası Konumu

APK dosyası şu konumda:
- `build/app/outputs/flutter-apk/app-release.apk` (61.3MB)

Veya proje kök dizininde:
- `linkcim-v1.0.0.apk` (eğer kopyalandıysa)

## GitHub Release Oluşturma Adımları

### 1. GitHub'a Git
1. Tarayıcınızda şu adrese gidin:
   - https://github.com/mehmetkaratslar/linkcim/releases
   - Veya: https://github.com/mehmet-karataslar/linkcim/releases

### 2. Yeni Release Oluştur
1. **"Draft a new release"** veya **"Create a new release"** butonuna tıklayın

### 3. Release Bilgilerini Doldur
- **Tag version**: `v1.0.0` (zaten oluşturuldu)
- **Release title**: `Linkcim v1.0.0 - İlk Stabil Sürüm`
- **Description** (aşağıdaki metni kullanabilirsiniz):

```markdown
## 🎉 Linkcim v1.0.0 - İlk Stabil Sürüm

### ✨ Yeni Özellikler
- 📁 **Video Koleksiyonları** - Videolarınızı özel koleksiyonlara organize edin
- 🔍 **Gelişmiş Arama** - Platform, kategori, etiket ve tarih filtreleri ile güçlü arama
- 🎨 **Modern UI** - Material Design 3 ile şık arayüz
- 🌍 **Çoklu Dil Desteği** - Türkçe ve İngilizce
- 🌓 **Tema Desteği** - Açık, koyu ve sistem teması

### 📱 Desteklenen Platformlar
- Instagram
- YouTube
- TikTok
- Twitter
- Facebook
- Vimeo
- Reddit

### 📥 Kurulum
1. APK dosyasını indirin
2. Cihazınızda "Bilinmeyen Kaynaklardan Yükleme" iznini verin
3. APK dosyasına tıklayarak yükleyin

### 🔒 Güvenlik
- Tüm veriler yerel olarak saklanır
- Hiçbir veri dışarı gönderilmez
- Açık kaynak kod

**Geliştirici**: Mehmet Karataş  
**Web**: https://www.benmuhendisiniz.com/
```

### 4. APK Dosyasını Yükle
1. **"Attach binaries"** veya dosya yükleme alanına tıklayın
2. Şu dosyayı seçin:
   - `build/app/outputs/flutter-apk/app-release.apk`
   - Veya `linkcim-v1.0.0.apk` (eğer kopyalandıysa)
3. Dosya adı otomatik olarak `app-release.apk` olacak, isterseniz `linkcim-v1.0.0.apk` olarak değiştirebilirsiniz

### 5. Release'i Yayınla
1. **"Publish release"** butonuna tıklayın
2. Release oluşturulacak ve APK dosyası indirilebilir olacak

## ✅ Kontrol Listesi

- [ ] GitHub releases sayfasına gidildi
- [ ] v1.0.0 tag'i seçildi
- [ ] Release başlığı ve açıklaması eklendi
- [ ] APK dosyası yüklendi
- [ ] Release yayınlandı
- [ ] APK dosyası indirilebilir durumda

## 📝 Notlar

- APK dosyası 61.3MB boyutunda, yükleme biraz zaman alabilir
- Release oluşturulduktan sonra README.md'deki linkler otomatik olarak çalışacak
- Gelecekte yeni sürümler için aynı adımları takip edebilirsiniz

