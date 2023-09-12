import 'package:flutter/material.dart';
import 'package:fluttertil/screens/syncfusion_flutter_charts.dart';
import 'package:fluttertil/routes/my_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BottomNavBar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    ChartApp(),
    const Center(child: Text("Page 1")),
    const Center(child: Text("Page 2")),
    const Center(child: Text("Page 3")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Example package'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ChartApp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Page 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Page 2',
          ),
        ],
      ),
    );
  }
}
