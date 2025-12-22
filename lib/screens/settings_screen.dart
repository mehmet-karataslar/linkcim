// Dosya Konumu: lib/screens/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:linkcim/l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'package:linkcim/services/database_service.dart';
import 'package:linkcim/services/theme_service.dart';
import 'package:linkcim/services/locale_service.dart';
import 'package:linkcim/services/permission_service.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final DatabaseService _dbService = DatabaseService();

  @override
  void initState() {
    super.initState();
  }


  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }


  Future<void> _showAboutDialog() async {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final packageInfo = await PackageInfo.fromPlatform();
    final deviceInfo = DeviceInfoPlugin();
    
    String platformInfo = '';
    String platformVersion = '';
    
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      platformInfo = 'Android';
      platformVersion = '${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})';
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      platformInfo = 'iOS';
      platformVersion = '${iosInfo.systemVersion}';
    } else if (Platform.isWindows) {
      platformInfo = 'Windows';
      platformVersion = 'Desktop';
    } else if (Platform.isLinux) {
      platformInfo = 'Linux';
      platformVersion = 'Desktop';
    } else if (Platform.isMacOS) {
      final macInfo = await deviceInfo.macOsInfo;
      platformInfo = 'macOS';
      platformVersion = macInfo.osRelease;
    } else {
      platformInfo = 'Unknown';
      platformVersion = 'Unknown';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                'assets/icons/iconumuz.png',
                width: 32,
                height: 32,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/icons/icon.png',
                    width: 32,
                    height: 32,
                  );
                },
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.appTitle,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'v${packageInfo.version} (${packageInfo.buildNumber})',
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Uygulama Açıklaması
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.appDescription ?? 'Video organizasyon uygulaması',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              
              // Teknik Bilgiler
              Text(
                l10n.technicalInformation ?? 'Teknik Bilgiler',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              SizedBox(height: 12),
              
              _buildInfoRow(Icons.code, l10n.framework ?? 'Framework', 'Flutter'),
              _buildInfoRow(Icons.phone_android, l10n.platform ?? 'Platform', platformInfo),
              _buildInfoRow(Icons.settings_system_daydream, l10n.systemVersion ?? 'Sistem Versiyonu', platformVersion),
              _buildInfoRow(Icons.storage, l10n.packageName ?? 'Paket Adı', packageInfo.packageName),
              _buildInfoRow(Icons.update, l10n.appVersion ?? 'Uygulama Versiyonu', '${packageInfo.version}+${packageInfo.buildNumber}'),
              
              SizedBox(height: 16),
              Divider(),
              SizedBox(height: 16),
              
              // Geliştirici Bilgileri
              Text(
                l10n.developer ?? 'Geliştirici',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
              SizedBox(height: 12),
              
              _buildInfoRow(Icons.person, l10n.developerName ?? 'Geliştirici', 'Mehmet Karataş'),
              _buildInfoRow(Icons.work, l10n.profession ?? 'Meslek', l10n.computerEngineer),
              
              SizedBox(height: 16),
              
              // Web Sayfası Butonu
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final url = Uri.parse('https://www.benmuhendisiniz.com/');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.linkOpenError ?? 'Link açılamadı'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.language),
                  label: Text(l10n.visitWebsite ?? 'Web Sitemi Ziyaret Et'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.close ?? 'Kapat'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.onSurfaceVariant),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  // İzin kontrol fonksiyonları - PermissionService kullan
  Future<Map<String, bool>> _checkPermissions() async {
    return await PermissionService.checkPermissions();
  }

  Future<void> _requestPermissions() async {
    final l10n = AppLocalizations.of(context)!;
    if (!Platform.isAndroid) {
      _showSuccess(l10n.iosAutoPermission);
      return;
    }

    try {
      _showSuccess(l10n.requestingPermissions);

      final results = await PermissionService.requestPermissions();
      final allGranted = results['all'] == PermissionStatus.granted;

      if (allGranted) {
        _showSuccess(l10n.permissionsGranted);
      } else {
        _showError(l10n.permissionsDenied);
      }

      setState(() {}); // Durumu güncelle
    } catch (e) {
      _showError('${l10n.permissionRequestError}: $e');
    }
  }

  Future<void> _showPermissionInfo() async {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.storage, color: theme.colorScheme.primary),
            SizedBox(width: 8),
            Text(l10n.storagePermissions),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.permissionInfo,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            _buildPermissionInfo(
                '📁 ${l10n.storageAccess}', l10n.storageAccessDesc),
            _buildPermissionInfo(
                '🎬 ${l10n.videoMediaAccess}', l10n.videoMediaAccessDesc),
            _buildPermissionInfo(
                '🔒 ${l10n.fileManagement}', l10n.fileManagementDesc),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                border: Border.all(color: theme.colorScheme.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info, color: theme.colorScheme.onPrimaryContainer, size: 20),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.dataPrivacy,
                      style: TextStyle(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionInfo(String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
          SizedBox(width: 8),
          Expanded(child: Text(description, style: TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Future<void> _confirmClearData() async {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.clearAllData),
        content: Text(l10n.clearDataWarning),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              l10n.delete,
              style: TextStyle(color: theme.colorScheme.error, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _clearAllData();
    }
  }

  Future<void> _clearAllData() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final videos = await _dbService.getAllVideos();
      for (final video in videos) {
        await _dbService.deleteVideo(video);
      }

      _showSuccess(l10n.dataCleared);
    } catch (e) {
      _showError('${l10n.clearDataError}: $e');
    }
  }

  Widget _buildSection(String title, List<Widget> children) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final themeService = Provider.of<ThemeService>(context);
    final localeService = Provider.of<LocaleService>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: ListView(
        children: [
          // Dil ve Tema Ayarları
          _buildSection('${l10n.language} & ${l10n.theme}', [
            // Dil Seçimi
            ListTile(
              leading: Icon(Icons.language, color: theme.colorScheme.primary),
              title: Text(l10n.language),
              subtitle: Text(
                localeService.currentLocale.languageCode == 'tr' 
                    ? l10n.turkish 
                    : l10n.english,
              ),
              trailing: DropdownButton<Locale>(
                value: localeService.currentLocale,
                items: [
                  DropdownMenuItem(
                    value: Locale('tr', ''),
                    child: Text(l10n.turkish),
                  ),
                  DropdownMenuItem(
                    value: Locale('en', ''),
                    child: Text(l10n.english),
                  ),
                ],
                onChanged: (Locale? newLocale) {
                  if (newLocale != null) {
                    localeService.setLocale(newLocale);
                  }
                },
              ),
            ),
            // Tema Seçimi
            ListTile(
              leading: Icon(Icons.palette, color: theme.colorScheme.primary),
              title: Text(l10n.theme),
              subtitle: Text(
                themeService.themeMode == ThemeMode.light
                    ? l10n.lightTheme
                    : themeService.themeMode == ThemeMode.dark
                        ? l10n.darkTheme
                        : l10n.systemTheme,
              ),
              trailing: DropdownButton<ThemeMode>(
                value: themeService.themeMode,
                items: [
                  DropdownMenuItem(
                    value: ThemeMode.light,
                    child: Text(l10n.lightTheme),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.dark,
                    child: Text(l10n.darkTheme),
                  ),
                  DropdownMenuItem(
                    value: ThemeMode.system,
                    child: Text(l10n.systemTheme),
                  ),
                ],
                onChanged: (ThemeMode? newMode) {
                  if (newMode != null) {
                    themeService.setThemeMode(newMode);
                  }
                },
              ),
            ),
          ]),
          
          Divider(),
          
          // İzin yönetimi
          _buildSection(l10n.permissions, [
            FutureBuilder<Map<String, bool>>(
              future: _checkPermissions(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final permissions = snapshot.data!;
                  final allGranted = permissions['all'] ?? false;

                  return Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.security,
                          color: allGranted ? theme.colorScheme.primary : theme.colorScheme.error,
                        ),
                        title: Text(l10n.storagePermissions),
                        subtitle: Text(
                          allGranted
                              ? l10n.allPermissionsGranted
                              : l10n.permissionsMissing,
                        ),
                        trailing: allGranted
                            ? Icon(Icons.check_circle, color: theme.colorScheme.primary)
                            : Icon(Icons.warning, color: theme.colorScheme.error),
                        onTap: _showPermissionInfo,
                      ),
                      if (!allGranted)
                        ListTile(
                          leading: Icon(Icons.settings, color: theme.colorScheme.primary),
                          title: Text(l10n.managePermissions),
                          subtitle:
                              Text(l10n.permissionsMissing),
                          onTap: _requestPermissions,
                        ),
                      ListTile(
                        leading: Icon(Icons.open_in_new, color: theme.colorScheme.onSurfaceVariant),
                        title: Text(l10n.systemSettings),
                        subtitle:
                            Text(l10n.manualEditPermissions),
                        onTap: openAppSettings,
                      ),
                    ],
                  );
                } else {
                  return ListTile(
                    leading: CircularProgressIndicator(strokeWidth: 2),
                    title: Text(l10n.checkingPermissions),
                  );
                }
              },
            ),
          ]),

          Divider(),

          // Veri yonetimi
          _buildSection(l10n.dataManagement, [
            ListTile(
              leading: Icon(Icons.delete_forever, color: theme.colorScheme.error),
              title: Text(l10n.clearAllData),
              subtitle: Text(l10n.carefulUse),
              onTap: _confirmClearData,
            ),
          ]),

          Divider(),

          // Uygulama bilgileri
          _buildSection(l10n.about, [
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.info, color: theme.colorScheme.onPrimaryContainer, size: 20),
              ),
              title: Text(l10n.about),
              subtitle: Text(l10n.appInformation),
              trailing: Icon(Icons.chevron_right),
              onTap: _showAboutDialog,
            ),
            ListTile(
              leading: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.language, color: theme.colorScheme.onSecondaryContainer, size: 20),
              ),
              title: Text(l10n.visitWebsite),
              subtitle: Text('www.benmuhendisiniz.com'),
              trailing: Icon(Icons.open_in_new, size: 18),
              onTap: () async {
                final url = Uri.parse('https://www.benmuhendisiniz.com/');
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(l10n.linkOpenError),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),
          ]),
        ],
      ),
    );
  }
}
