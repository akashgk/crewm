import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'download/download_mp.dart';

class DownloadService {
  Future<void> downloadFile(
    String fileName,
    String content,
    String mime,
  ) async {
    downloadFileFromString(fileName, content, mime);
  }
}

final downloadServiceProvider = Provider<DownloadService>((ref) {
  return DownloadService();
});
