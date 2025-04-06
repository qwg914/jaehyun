import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '현재 시각',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _currentTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateTime(); // 초기 시간 설정
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _updateTime(); // 1초마다 시간 갱신
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // 타이머 해제
    super.dispose();
  }

  void _updateTime() {
    final now = DateTime.now();
    setState(() {
      _currentTime = DateFormat('yyyy년 MM월 dd일 \na hh시 mm분 ss초'
      ).format(now); // 날짜와 시간 형식 지정
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('현재 시각'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Text(
          _currentTime,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}