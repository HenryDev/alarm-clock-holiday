class Alarm {
  DateTime dateTime;
  bool isExpanded;

  Alarm(this.dateTime, this.isExpanded);

  static Map<String, dynamic> toJson(Alarm alarm) => {'dateTime': alarm.dateTime.toIso8601String(), 'isExpanded': alarm.isExpanded};

  Alarm.fromJson(Map<String, dynamic> json)
      : dateTime = json['dateTime'],
        isExpanded = json['isExpanded'];
}
