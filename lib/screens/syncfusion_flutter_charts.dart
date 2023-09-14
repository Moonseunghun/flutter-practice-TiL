import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(const _ChartApp());
}

class _ChartApp extends StatelessWidget {
  const _ChartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.grey),
      home: const ChartApp(),
    );
  }
}

class ChartApp extends StatefulWidget {
  const ChartApp({Key? key}) : super(key: key);

  @override
  ChartAppState createState() => ChartAppState();
}

class ChartAppState extends State<ChartApp> {
  List<_DailyScoreData> data = [
    _DailyScoreData('1', 90, 85, 78),
    _DailyScoreData('2', 88, 84, 76),
    _DailyScoreData('3', 92, 87, 79),
    _DailyScoreData('4', 89, 86, 77),
    _DailyScoreData('5', 94, 89, 82),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCartesianChart(
        primaryXAxis: CategoryAxis(),
        title: ChartTitle(text: 'Daily Scores'),
        legend: const Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
        series: <ChartSeries<_DailyScoreData, String>>[
          LineSeries<_DailyScoreData, String>(
            dataSource: data,
            xValueMapper: (_DailyScoreData score, _) => score.day,
            yValueMapper: (_DailyScoreData score, _) => score.koreanScore,
            name: '국어',
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
          LineSeries<_DailyScoreData, String>(
            dataSource: data,
            xValueMapper: (_DailyScoreData score, _) => score.day,
            yValueMapper: (_DailyScoreData score, _) => score.englishScore,
            name: '영어',
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
          LineSeries<_DailyScoreData, String>(
            dataSource: data,
            xValueMapper: (_DailyScoreData score, _) => score.day,
            yValueMapper: (_DailyScoreData score, _) => score.mathScore,
            name: '수학',
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
      ),
    );
  }
}

class _DailyScoreData {
  _DailyScoreData(
      this.day, this.koreanScore, this.englishScore, this.mathScore);

  final String day;
  final double koreanScore;
  final double englishScore;
  final double mathScore;
}
