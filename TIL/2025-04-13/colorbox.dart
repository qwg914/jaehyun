import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            // 상단 
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  // 왼쪽 빨간색 (상단 왼쪽쪽)
                  Expanded(
                    flex: 1,
                    child: Container(color: Colors.red),
                  ),
                  // 오른쪽 영역
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        // 파란색 (오른쪽 위 절반)
                        Expanded(
                          flex: 1,
                          child: Container(color: Colors.blue.shade900),
                        ),
                        // 검정 + 주황 (아래 Row로 나눔)
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(color: Colors.black),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(color: Colors.orange),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // 하단 노란색
            Expanded(
              flex: 1,
              child: Container(color: Colors.yellow),
            ),
          ],
        ),
      ),
    );
  }
}
