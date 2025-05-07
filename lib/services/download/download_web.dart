// ignore_for_file: deprecated_member_use
import 'dart:html' as html;

Future<void> downloadFileFromString(
  String fileName,
  String content,
  String mime,
) async {
  final blob = html.Blob([content], mime);
  final url = html.Url.createObjectUrlFromBlob(blob);
  html.AnchorElement(href: url)
    ..setAttribute('download', fileName)
    ..click();
  html.Url.revokeObjectUrl(url);
}
