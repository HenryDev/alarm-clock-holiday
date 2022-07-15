import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalStorage {
  Future<String> get _localPath async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final String path = await _localPath;
    var file = File('$path/alarms.txt');
    if (file.existsSync()) {
      return file;
    } else {
      return file.create();
    }
  }

  Future<String> readFile() async {
    final File file = await _localFile;
    return await file.readAsString();
  }

  Future<File> writeFile(String content) async {
    final file = await _localFile;
    return file.writeAsString(content, mode: FileMode.append, flush: true);
  }
}
