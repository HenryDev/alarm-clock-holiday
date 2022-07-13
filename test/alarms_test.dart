import 'package:alarm_clock_holiday/alarm.dart';
import 'package:alarm_clock_holiday/main.dart';
import 'package:test/test.dart';

void main() {
  var date = '1969-11-11T01:03:37.031337';
  var date1 = '1969-11-11T03:13:37.313370';
  var alarms = [Alarm(DateTime.parse(date), false), Alarm(DateTime.parse(date1), false)];
  var jsonAlarms = '[{"dateTime":"$date","isExpanded":false},{"dateTime":"$date1","isExpanded":false}]';
  test('createAlarms should create alarms from string', () {
    var result = createAlarms(jsonAlarms);
    expect(result, equals(alarms));
  });
  test('convertAlarmsToText should serialize alarms', () {
    var result = convertAlarmsToText(alarms);
    expect(result, equals(jsonAlarms));
  });
}
