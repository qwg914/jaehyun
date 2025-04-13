import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: FirstPage(),
      home: FirstStatefulPage(),
    );
  }
}
// class FirstPage extends StatelessWidget {
//   const FirstPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     print('FirstPage build()');
//     return Scaffold(
//       body: Center(
//         child: TextButton(
//           onPressed: () async {
//             final result = await Navigator.push(
//               context,
//               MaterialPageRoute(builder: (_) => const SecondPage()),
//             );
//             print('돌아온 값: $result');
//           },
//           child: const Text('Go'),
//         ),
//       ),
//     );
//   }
// }
// class SecondPage extends StatelessWidget {
//   const SecondPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     print('SecondPage build()');
//     return Scaffold(
//       body: Center(
//         child: TextButton(
//           onPressed: () {
//             Navigator.pop(context, 'ok');
//           },
//           child: const Text('Back with OK'),
//         ),
//       ),
//     );
//   }
// }
class Person {
  final String name;
  final int age;
  Person(this.name, this.age);
}

class FirstStatefulPage extends StatefulWidget {
  const FirstStatefulPage({super.key});
  @override
  State<FirstStatefulPage> createState() => _FirstStatefulPageState();
}
class _FirstStatefulPageState extends State<FirstStatefulPage> {
  @override
  void initState() {
    super.initState();
    print('FirstPage initState()');
  }
  @override
  void dispose() {
    super.dispose();
    print('FirstPage dispose()');
  }
  @override
  Widget build(BuildContext context) {
    print('FirstPage build()');
    return Scaffold(
      appBar: AppBar(title: const Text('First')),
      body: Center(
        child: ElevatedButton(
          child: const Text('다음 페이지로'),
          onPressed: () {
            Person person = Person('홍길동', 20);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SecondStatefulPage(person: person),
              ),
            ).then((_) {
              // pop 후 build 호출 확인용
              setState(() {}); // ← 없으면 생략 가능하지만 확인용으로 유지
            });
          },
        ),
      ),
    );
  }
  }
class SecondStatefulPage extends StatefulWidget {
  final Person person;
  const SecondStatefulPage({super.key, required this.person});

  @override
  State<SecondStatefulPage> createState() => _SecondStatefulPageState();
}

class _SecondStatefulPageState extends State<SecondStatefulPage> {
  @override
  void initState() {
    super.initState();
    print('SecondPage initState()');
  }
  @override
  void dispose() {
    super.dispose();
    print('SecondPage dispose()');
  }
  @override
  Widget build(BuildContext context) {
    print('SecondPage build()');
    return Scaffold(
      appBar: AppBar(title: Text(widget.person.name)),
      body: Center(
        child: ElevatedButton(
          child: const Text('이전 페이지로'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}