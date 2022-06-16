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

  Future<List<String>> readFile() async {
    final file = await _localFile;
    return await file.readAsLines();
  }

  Future<File> writeFile(List<Alarm> alarms) async {
    final file = await _localFile;
    String content = alarms.map((alarm) => alarm.dateTime).toList().toString();
    return file.writeAsString(content);
  }
}
