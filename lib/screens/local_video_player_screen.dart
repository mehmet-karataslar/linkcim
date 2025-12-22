import 'package:flutter/material.dart';
import 'package:linkcim/l10n/app_localizations.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'dart:io';

class LocalVideoPlayerScreen extends StatefulWidget {
  final String videoPath;
  final String videoTitle;

  const LocalVideoPlayerScreen({
    Key? key,
    required this.videoPath,
    required this.videoTitle,
  }) : super(key: key);

  @override
  _LocalVideoPlayerScreenState createState() => _LocalVideoPlayerScreenState();
}

class _LocalVideoPlayerScreenState extends State<LocalVideoPlayerScreen> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _isLoading = true;
  bool _hasError = false;
  String? _errorMessage;
  int _retryCount = 0;
  static const int _maxRetries = 3;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  @override
  void dispose() {
    _chewieController?.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> _initializePlayer({bool isRetry = false}) async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
        _errorMessage = null;
      });

      // Video dosyasının var olup olmadığını kontrol et
      final file = File(widget.videoPath);
      if (!await file.exists()) {
        throw Exception('Video dosyası bulunamadı: ${widget.videoPath}');
      }

      // Dosya okunabilir mi kontrol et
      if (!await file.exists() || !await file.stat().then((stat) => stat.size > 0)) {
        throw Exception('Video dosyası boş veya okunamıyor');
      }

      // Önceki controller'ları temizle
      _chewieController?.dispose();
      await _videoPlayerController?.dispose();

      // Video player controller'ı oluştur
      _videoPlayerController = VideoPlayerController.file(file);
      
      // Timeout ile initialize et
      await _videoPlayerController!.initialize().timeout(
        Duration(seconds: 10),
        onTimeout: () {
          throw Exception('Video yükleme zaman aşımına uğradı');
        },
      );

      // Chewie controller'ı oluştur
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController!,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.blue,
          handleColor: Colors.blueAccent,
          backgroundColor: Colors.grey,
          bufferedColor: Colors.lightBlue,
        ),
        placeholder: Container(
          color: Colors.black,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 60,
                ),
                SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.videoCannotPlay,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  errorMessage,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      );

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      // Retry mekanizması
      if (_retryCount < _maxRetries && !isRetry) {
        _retryCount++;
        await Future.delayed(Duration(seconds: 2));
        return _initializePlayer(isRetry: true);
      }

      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = _getErrorMessage(e);
      });
    }
  }

  String _getErrorMessage(dynamic error) {
    final errorString = error.toString().toLowerCase();
    
    if (errorString.contains('file') && errorString.contains('not found')) {
      return 'Video dosyası bulunamadı. Dosya silinmiş veya taşınmış olabilir.';
    } else if (errorString.contains('timeout')) {
      return 'Video yükleme zaman aşımına uğradı. Lütfen tekrar deneyin.';
    } else if (errorString.contains('format') || errorString.contains('codec')) {
      return 'Video formatı desteklenmiyor. Lütfen farklı bir video deneyin.';
    } else if (errorString.contains('permission')) {
      return 'Video dosyasına erişim izni yok. Lütfen ayarlardan izin verin.';
    } else {
      return 'Video oynatılamadı: ${error.toString()}';
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    } else {
      return "$twoDigitMinutes:$twoDigitSeconds";
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024)
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          widget.videoTitle,
          style: TextStyle(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          if (!_hasError && !_isLoading)
            IconButton(
              icon: Icon(Icons.info_outline, color: Colors.white),
              onPressed: _showVideoInfo,
              tooltip: 'Video Bilgileri',
            ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return _buildLoadingWidget();
    }

    if (_hasError) {
      return _buildErrorWidget();
    }

    if (_chewieController != null) {
      return Column(
        children: [
          Expanded(
            child: Chewie(controller: _chewieController!),
          ),
          _buildVideoInfoBar(),
        ],
      );
    }

    return _buildErrorWidget();
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.videoLoading,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Text(
            widget.videoTitle,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 80,
          ),
          SizedBox(height: 20),
          Text(
            'Video Oynatılamadı',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              _errorMessage ?? 'Bilinmeyen bir hata oluştu',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _retryCount = 0; // Retry sayacını sıfırla
              });
              _initializePlayer();
            },
            icon: Icon(Icons.refresh),
            label: Text('Tekrar Dene'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          SizedBox(height: 16),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Geri Dön',
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoInfoBar() {
    if (_videoPlayerController == null) return SizedBox.shrink();

    final duration = _videoPlayerController!.value.duration;
    final file = File(widget.videoPath);

    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.black87,
      child: Row(
        children: [
          Icon(Icons.play_circle_outline, color: Colors.white70, size: 20),
          SizedBox(width: 8),
          Text(
            _formatDuration(duration),
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          SizedBox(width: 16),
          Icon(Icons.storage, color: Colors.white70, size: 20),
          SizedBox(width: 8),
          FutureBuilder<int>(
            future: file.length(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  _formatFileSize(snapshot.data!),
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                );
              }
              return Text(
                'Boyut hesaplanıyor...',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              );
            },
          ),
          Spacer(),
          Text(
            'HD',
            style: TextStyle(
              color: Colors.blue,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showVideoInfo() {
    if (_videoPlayerController == null) return;

    final duration = _videoPlayerController!.value.duration;
    final size = _videoPlayerController!.value.size;
    final file = File(widget.videoPath);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.video_library, color: Colors.blue),
            SizedBox(width: 12),
            Text('Video Bilgileri'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Başlık:', widget.videoTitle),
            _buildInfoRow('Süre:', _formatDuration(duration)),
            _buildInfoRow(
                'Çözünürlük:', '${size.width.toInt()}x${size.height.toInt()}'),
            FutureBuilder<int>(
              future: file.length(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _buildInfoRow(
                      'Dosya Boyutu:', _formatFileSize(snapshot.data!));
                }
                return _buildInfoRow('Dosya Boyutu:', 'Hesaplanıyor...');
              },
            ),
            _buildInfoRow('Dosya Yolu:', widget.videoPath),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              backgroundColor: Colors.blue[50],
              foregroundColor: Colors.blue[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('Tamam'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[900],
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
