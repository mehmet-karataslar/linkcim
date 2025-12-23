import java.util.Properties
import java.io.FileInputStream

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
}

// Keystore bilgilerini yükle
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.linkcim.linkcim"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.linkcim.linkcim"
        // Play Store için minimum SDK 21 (Android 5.0) önerilir
        minSdk = flutter.minSdkVersion
        // Target SDK 34 (Android 14) - Play Store'un güncel gereksinimi
        targetSdk = 34
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        
        // MultiDex desteği (gerekirse)
        multiDexEnabled = true
    }

    signingConfigs {
        create("release") {
            if (keystorePropertiesFile.exists()) {
                val storeFileProperty = keystoreProperties.getOrDefault("storeFile", null) as String?
                if (storeFileProperty != null) {
                    val keystoreFile = rootProject.file(storeFileProperty)
                    if (keystoreFile.exists()) {
                        keyAlias = keystoreProperties.getOrDefault("keyAlias", "upload") as String
                        keyPassword = keystoreProperties.getOrDefault("keyPassword", "") as String
                        storeFile = keystoreFile
                        storePassword = keystoreProperties.getOrDefault("storePassword", "") as String
                    }
                }
            }
        }
    }

    buildTypes {
        release {
            // Release build için keystore kullan
            signingConfig = signingConfigs.getByName("release")
            
            // ProGuard/R8 - Play Store için optimize edilmiş
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
        debug {
            // Debug build için debug signing kullan
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
