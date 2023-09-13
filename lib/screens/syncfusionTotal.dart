import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const CombinedApp(),
    );
  }
}

class CombinedApp extends StatefulWidget {
  const CombinedApp({Key? key}) : super(key: key);

  @override
  CombinedAppState createState() => CombinedAppState();
}

class CombinedAppState extends State<CombinedApp> {
  List<_SalesData> chartData = [];
  List<_SalesData> chartDataForDisplay = [];

  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  @override
  void initState() {
    super.initState();
    chartData = _SalesData.generateRandomData(
        DateTime(2023, 9, 1), DateTime(2023, 9, 30));
    chartDataForDisplay.addAll(chartData);
  }

  List<_SalesData> getFilteredChartData() {
    if (_selectedStartDate == null || _selectedEndDate == null) {
      return chartData;
    } else {
      final filteredData = chartData.where((data) {
        final DateTime dataDate = data.year;
        return dataDate.isAfter(_selectedStartDate!) &&
            dataDate.isBefore(_selectedEndDate!);
      }).toList();
      return filteredData;
    }
  }

  void updateChartData() {
    if (_selectedStartDate != null && _selectedEndDate != null) {
      final startDate = _selectedStartDate!;
      final endDate = _selectedEndDate!.add(Duration(days: 1));
      final filteredData = _SalesData.generateRandomData(startDate, endDate);
      setState(() {
        chartDataForDisplay.clear();
        chartDataForDisplay.addAll(filteredData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: SfCartesianChart(
              primaryXAxis: DateTimeAxis(),
              title: ChartTitle(text: 'Half yearly sales analysis'),
              legend: const Legend(isVisible: true),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_SalesData, DateTime>>[
                BarSeries<_SalesData, DateTime>(
                  dataSource: chartDataForDisplay,
                  xValueMapper: (_SalesData sales, _) => sales.year,
                  yValueMapper: (_SalesData sales, _) => sales.sales,
                  name: 'Sales',
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SfCalendar(
              view: CalendarView.month,
              onLongPress: (calendarLongPressDetails) {
                setState(() {
                  if (_selectedStartDate == null || _selectedEndDate != null) {
                    _selectedStartDate = calendarLongPressDetails.date;
                    _selectedEndDate = null;
                  } else {
                    _selectedEndDate = calendarLongPressDetails.date;
                  }
                  print('Selected Start Date: $_selectedStartDate');
                  print('Selected End Date: $_selectedEndDate');
                  updateChartData();
                });
              },
              dataSource: MeetingDataSource(_getDataSource()),
              monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(today.year, today.month, today.day, 9);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Work Today', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);

  final DateTime year;
  final double sales;

  static List<_SalesData> generateRandomData(
      DateTime startDate, DateTime endDate) {
    final random = Random();
    final data = <_SalesData>[];
    for (var date = startDate;
        date.isBefore(endDate);
        date = date.add(Duration(days: 1))) {
      data.add(_SalesData(date, random.nextDouble() * 100));
    }
    return data;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getMeetingData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getMeetingData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }
    return meetingData;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
