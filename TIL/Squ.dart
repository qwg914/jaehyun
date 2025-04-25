import 'dart:io';

void main() {
  // int n = 10; // 다트패드라서 고정값
    stdout.write('사각형의 한 변의 길이를 입력하세요: ');
    int n = int.parse(stdin.readLineSync()!);


  print('꽉 찬 사각형');
  fullSqu(n);
  print('\n테두리 사각형');
  borderSqu(n);
  print('\n/표시사각형');
  slashSqu(n);
  print('\n\\표시사각형');
  backslashSqu(n);
  print('\nX표시사각형');
  xSqu(n);
}
void fullSqu(int n) {
  for (int i = 0; i < n; i++) {
    print('#' * n);
  }
}
void borderSqu(int n) {
  for (int i = 0; i < n; i++) {
    if (i == 0 || i == n - 1) {
      print('#' * n);
    } else {
      print('#' + ' ' * (n - 2) + '#');
    }
  }
}
void slashSqu(int n) {
  for (int i = 0; i < n; i++) {
    String line = '';
    for (int j = 0; j < n; j++) {
      if (i == 0 || i == n - 1 || j == 0 || j == n - 1 || j == n - 1 - i) {
        line += '#';
      } else {
        line += ' ';
      }
    }
    print(line);
  }
}
void backslashSqu(int n) {
  for (int i = 0; i < n; i++) {
    String line = '';
    for (int j = 0; j < n; j++) {
      if (i == 0 || i == n - 1 || j == 0 || j == n - 1 || i == j) {
        line += '#';
      } else {
        line += ' ';
      }
    }
    print(line);
  }
}
void xSqu(int n) {
  for (int i = 0; i < n; i++) {
    String line = '';
    for (int j = 0; j < n; j++) {
      if (i == 0 || i == n - 1 || j == 0 || j == n - 1 || j == i || j == n - 1 - i) {
        line += '#';
      } else {
        line += ' ';
      }
    }
    print(line);
  }
}
