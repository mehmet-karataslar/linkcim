// Dosya Konumu: lib/screens/settings_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:linkcim/l10n/app_localizations.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
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
    showAboutDialog(
      context: context,
      applicationName: l10n.appTitle,
      applicationVersion: '1.0.0',
      applicationIcon: Icon(Icons.video_library, size: 48),
      children: [
        Text(l10n.appInfo),
        SizedBox(height: 8),
        Text(l10n.organizeVideos),
        SizedBox(height: 8),
        Text(l10n.developedWith),
      ],
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
              leading: Icon(Icons.info, color: theme.colorScheme.primary),
              title: Text(l10n.about),
              subtitle: Text(l10n.appInformation),
              onTap: _showAboutDialog,
            ),
          ]),
        ],
      ),
    );
  }
}
