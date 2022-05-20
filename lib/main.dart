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
      home: const MyHomePage(title: 'Alarm Clock Holiday'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> _items = List.generate(
      5,
      (index) => {
            'id': index,
            'title': 'Item $index',
            'description': 'This is the description of the item $index. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
            'isExpanded': false
          });

  void _incrementCounter() {
    setState(() {
      Map<String, dynamic> item = {
        'id': 6,
        'title': 'Item 6',
        'description': 'This is the description of the item 6. Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        'isExpanded': false
      };
      _items.add(item);
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
              children: _items
                  .map(
                    (item) => ExpansionPanel(
                        canTapOnHeader: true,
                        backgroundColor: item['isExpanded'] ? const Color.fromARGB(255, 242, 242, 242) : Colors.white,
                        headerBuilder: (context, isExpanded) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Text(item['title'], style: const TextStyle(fontSize: 20)),
                          );
                        },
                        body: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Text(item['description']),
                        ),
                        isExpanded: item['isExpanded']),
                  )
                  .toList(),
              expansionCallback: toggleExpansion,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.large(
        onPressed: _incrementCounter,
        tooltip: 'Add new alarm',
        child: const Icon(Icons.add),
      ),
    );
  }

  void toggleExpansion(panelIndex, isExpanded) {
    setState(() {
      _items[panelIndex]['isExpanded'] = !isExpanded;
    });
  }
}
