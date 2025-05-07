import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  Future<List<dynamic>> readJsonFile(String path) async {
    final content = await rootBundle.loadString(path);
    final data = jsonDecode(content);
    return data['payload'];
  }

  Future<File> writeICal(String name, int id, String content) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/absence_${name}_$id.ics');
    return file.writeAsString(content);
  }
}

final fileServiceProvider = Provider<FileService>((ref) {
  return FileService();
});
