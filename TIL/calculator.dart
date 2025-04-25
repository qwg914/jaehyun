import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '계산기', // 앱 이름
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              // 상단 숫자 표시 영역
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.bottomRight, // 오른쪽 아래 정렬
                  padding: EdgeInsets.all(24),       // 여백
                  child: Text(
                    '0',
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // 메모리 기능 버튼 (디스플레이 아래에 위치)
              Container(
                padding: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: memoryButtons.map((label) {
                    return Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    );
                  }).toList(),
                ),
              ),

              // 버튼 영역
              Expanded(
                flex: 5,
                child: Column(
                  children: buttons.map((row) {
                    return Expanded(
                      child: Row(
                        children: row.map((label) {
                          return Expanded(
                            child: Container(
                              margin: EdgeInsets.all(1), // 버튼 간 여백
                              color: label == '='
                                  ? Colors.blue          // '='만 파란색
                                  : Colors.grey[850],    // 나머지는 어두운 회색
                              child: Center(
                                child: Text(
                                  label,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 메모리 버튼 텍스트
List<String> memoryButtons = ['MC', 'MR', 'M+', 'M-', 'MS', 'M∨'];

// 하단 버튼 구성 (6행 x 4열)
List<List<String>> buttons = [
  ['%', 'CE', 'C', '⌫'],
  ['⅟x', 'x²', '√x', '÷'],
  ['7', '8', '9', '×'],
  ['4', '5', '6', '-'],
  ['1', '2', '3', '+'],
  ['±', '0', '.', '='],
];
