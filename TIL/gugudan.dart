void main() { //구구단
  for (int i = 2; i <= 9; i++) {
    for (int j = 1; j <= 9; j++) {
      print('$i x $j = ${i * j}');
    }
    print(''); // 단 띄우기
  }
}
