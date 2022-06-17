import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'alarm.dart';

class LocalStorage {
  Future<String> get _localPath async {
    var directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/alarms.txt');
  }

  Future<String> readFile() async {
    final file = await _localFile;
    return await file.readAsString();
  }

  Future<File> writeFile(List<Alarm> alarms) async {
    final file = await _localFile;
    String content = jsonEncode(alarms);
    return file.writeAsString(content, mode: FileMode.append, flush: true);
  }
}
