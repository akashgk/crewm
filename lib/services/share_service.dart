import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  Future<void> shareFile(String path) async {
    final params = ShareParams(files: [XFile(path)]);
    await SharePlus.instance.share(params);
  }
}

final shareServiceProvider = Provider<ShareService>((ref) {
  return ShareService();
});
