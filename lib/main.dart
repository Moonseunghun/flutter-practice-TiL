import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:fluttertil/screens/syncfusion_flutter_charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Grid Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChartApp(),
    );
  }
}
