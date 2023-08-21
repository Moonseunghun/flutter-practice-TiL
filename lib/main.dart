import 'package:flutter/material.dart';
import 'package:fluttertil/screens/community.dart';
// 수정된 import 경로

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(), // 로그인 페이지를 홈으로 설정합니다.
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 로그인 버튼 클릭 시 커뮤니티 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CommunityPage()),
            );
          },
          child: const Text('로그인'),
        ),
      ),
    );
  }
}
