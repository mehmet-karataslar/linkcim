// Dosya Konumu: lib/services/permission_service.dart
// İzin yönetimi servisi

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:linkcim/l10n/app_localizations.dart';

class PermissionService {
  static const String _permissionRequestedKey = 'permission_requested';
  static const String _permissionGrantedKey = 'permission_granted';

  // İzin durumunu kontrol et
  static Future<Map<String, bool>> checkPermissions() async {
    if (!Platform.isAndroid) {
      return {'all': true, 'platform': false}; // iOS için varsayılan
    }

    try {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      Map<String, bool> permissions = {};
      bool allGranted = false;

      if (sdkInt >= 33) {
        // Android 13+ (API 33+) - Sadece video izni yeterli
        final videoStatus = await Permission.videos.status;
        final isGranted = videoStatus.isGranted;
        permissions['videos'] = isGranted;
        // Android 13+ için sadece video izni yeterli, photos gereksiz
        allGranted = isGranted;
        print('🔍 Android 13+ İzin Durumu: videos=$videoStatus, isGranted=$isGranted');
        
        // Eğer izin verilmemişse ama kısıtlı izin varsa kontrol et
        if (!isGranted && videoStatus == PermissionStatus.limited) {
          print('⚠️ Video izni kısıtlı (limited) - kabul ediliyor');
          allGranted = true;
          permissions['videos'] = true;
        }
      } else if (sdkInt >= 30) {
        // Android 11-12 (API 30-32)
        final manageStatus = await Permission.manageExternalStorage.status;
        final storageStatus = await Permission.storage.status;
        final manageGranted = manageStatus.isGranted;
        final storageGranted = storageStatus.isGranted;
        permissions['manageStorage'] = manageGranted;
        permissions['storage'] = storageGranted;
        // Herhangi biri verilmişse yeterli
        allGranted = manageGranted || storageGranted;
        print('🔍 Android 11-12 İzin Durumu: manageStorage=$manageStatus ($manageGranted), storage=$storageStatus ($storageGranted)');
      } else {
        // Android 10 ve altı
        final storageStatus = await Permission.storage.status;
        final isGranted = storageStatus.isGranted;
        permissions['storage'] = isGranted;
        allGranted = isGranted;
        print('🔍 Android 10- İzin Durumu: storage=$storageStatus, isGranted=$isGranted');
      }
      
      print('✅ İzin Kontrol Sonucu: allGranted=$allGranted, permissions=$permissions');

      permissions['all'] = allGranted;
      permissions['platform'] = true;
      return permissions;
    } catch (e, stackTrace) {
      print('❌ İzin kontrolü hatası: $e');
      print('Stack trace: $stackTrace');
      return {'all': false, 'platform': true};
    }
  }

  // İzinleri iste
  static Future<Map<String, PermissionStatus>> requestPermissions() async {
    if (!Platform.isAndroid) {
      return {'all': PermissionStatus.granted};
    }

    try {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;

      Map<String, PermissionStatus> results = {};

      if (sdkInt >= 33) {
        // Android 13+ (API 33+) - Sadece video izni yeterli
        print('📱 Android 13+ için video izni isteniyor...');
        final videoStatus = await Permission.videos.request();
        results['videos'] = videoStatus;
        // Android 13+ için sadece video izni yeterli
        results['all'] = videoStatus.isGranted
            ? PermissionStatus.granted
            : PermissionStatus.denied;
        print('📱 Video izni sonucu: ${videoStatus.toString()}, granted: ${videoStatus.isGranted}');
      } else if (sdkInt >= 30) {
        // Android 11-12 (API 30-32)
        final manageStatus = await Permission.manageExternalStorage.request();
        final storageStatus = await Permission.storage.request();
        results['manageStorage'] = manageStatus;
        results['storage'] = storageStatus;
        results['all'] = (manageStatus.isGranted || storageStatus.isGranted)
            ? PermissionStatus.granted
            : PermissionStatus.denied;
      } else {
        // Android 10 ve altı
        final storageStatus = await Permission.storage.request();
        results['storage'] = storageStatus;
        results['all'] = storageStatus;
      }

      // İzin durumunu kaydet
      final granted = results['all'] == PermissionStatus.granted;
      await _savePermissionStatus(granted);
      
      print('💾 İzin durumu kaydedildi: granted=$granted');
      print('📊 İzin sonuçları: $results');

      return results;
    } catch (e) {
      print('İzin isteme hatası: $e');
      return {'all': PermissionStatus.denied};
    }
  }

  // İlk açılışta izin istenmiş mi kontrol et
  static Future<bool> hasRequestedPermissions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_permissionRequestedKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  // İzin durumunu kaydet
  static Future<void> _savePermissionStatus(bool granted) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_permissionRequestedKey, true);
      await prefs.setBool(_permissionGrantedKey, granted);
    } catch (e) {
      print('İzin durumu kaydetme hatası: $e');
    }
  }

  // İzin verilmiş mi kontrol et
  static Future<bool> arePermissionsGranted() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getBool(_permissionGrantedKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  // İzin dialog'unu göster
  static Future<bool?> showPermissionDialog(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return null;

    final theme = Theme.of(context);
    final permissions = await checkPermissions();
    final allGranted = permissions['all'] ?? false;

    if (allGranted) return true;

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.security_rounded,
                color: theme.colorScheme.primary,
                size: 28,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                l10n.storagePermissions,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.permissionInfo,
              style: TextStyle(
                fontSize: 16,
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            SizedBox(height: 20),
            _buildPermissionItem(
              context,
              Icons.video_library_rounded,
              l10n.videoAccess,
              l10n.videoAccessDescription,
            ),
            SizedBox(height: 12),
            _buildPermissionItem(
              context,
              Icons.folder_rounded,
              l10n.storageAccess,
              l10n.storageAccessDesc,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text(
              l10n.later,
              style: TextStyle(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(context).pop(true);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              l10n.grantPermission,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildPermissionItem(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 20,
            color: theme.colorScheme.onSecondaryContainer,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

