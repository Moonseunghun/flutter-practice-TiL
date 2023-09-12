import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fluttertil/screens/syncfusion_flutter_charts.dart'; // ChartApp 컴포넌트 파일을 import

final List<GoRoute> appRoutes = [
  GoRoute(
    builder: (context, state) => ChartApp(), // ChartApp 인스턴스를 반환
    name: 'Page 1',
    path: '/lib/screens/syncfusion_flutter_charts.dart',
  ),
  GoRoute(
    builder: (context, state) => Center(child: Text("Page 2")),
    name: 'Page 2',
    path: '/page2',
  ),
  GoRoute(
    builder: (context, state) => Center(child: Text("Page 3")),
    name: 'Page 3',
    path: '/page3',
  ),
];
