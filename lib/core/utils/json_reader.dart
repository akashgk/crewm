import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<dynamic>> readJsonFile(String path) async {

  final content = await rootBundle.loadString(path);
  final data = jsonDecode(content);
  return data['payload'];
}