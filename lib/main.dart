import 'dart:io';

import 'package:alarm_clock_holiday/alarm.dart';
import 'package:alarm_clock_holiday/local_storage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Alarm Clock Holiday', storage: LocalStorage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.storage});

  final LocalStorage storage;
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Alarm> _alarms = [];

  @override
  void initState() {
    super.initState();
    widget.storage.readFile().then((List<String> lines) {
      setState(() {
        _alarms = lines.map((line) => Alarm(DateTime.parse(line), false)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Alarms',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ExpansionPanelList(
              children: _alarms
                  .map(
                    (alarm) => ExpansionPanel(
                      canTapOnHeader: true,
                      backgroundColor: alarm.isExpanded ? const Color.fromARGB(255, 242, 242, 242) : Colors.white,
                      headerBuilder: (context, isExpanded) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Text(alarm.dateTime.toString(), style: const TextStyle(fontSize: 20)),
                        );
                      },
                      body: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Text(alarm.dateTime.toString()),
                      ),
                      isExpanded: alarm.isExpanded,
                    ),
                  )
                  .toList(),
              expansionCallback: toggleExpansion,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: _addAlarm,
        tooltip: 'Add new alarm',
        child: const Icon(Icons.add),
      ),
    );
  }

  void toggleExpansion(index, isExpanded) {
    setState(() {
      _alarms[index].isExpanded = !isExpanded;
    });
  }

  Future<File> _addAlarm() {
    setState(() {
      _alarms.add(Alarm(DateTime.now(), true));
    });
    return widget.storage.writeFile(_alarms);
  }
}
