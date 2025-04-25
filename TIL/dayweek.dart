import 'dart:io';

void main() {
  stdout.write('날짜를 입력하세요 (예: 2025-03-23): ');
  String input = stdin.readLineSync()!;
  
  DateTime date = DateTime.parse(input);

  // 요일 목록
  List<String> weekdays = ['월', '화', '수', '목', '금', '토', '일'];

  String result = weekdays[date.weekday - 1];
  print('입력한 날짜의 요일은 $result요일입니다.');
}