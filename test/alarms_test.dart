import 'package:alarm_clock_holiday/alarm.dart';
import 'package:alarm_clock_holiday/main.dart';
import 'package:test/test.dart';

void main() {
  var alarms = [Alarm(DateTime.now(), false), Alarm(DateTime.now().add(const Duration(days: 1)), false)];
  test('createAlarms should create list from string', () {
    var result = createAlarms("content");
    expect(result, equals(alarms));
  });
  test('convertAlarmsToText should serialize alarms', () {
    var result = convertAlarmsToText(alarms);
    expect(result, equals('alarms'));
  });
}
