import 'package:flutter/material.dart';
import 'package:lifecycle/person.dart';

class SecondPage extends StatelessWidget {
  Person? person;

  SecondPage({this.person});

  @override
  Widget build(BuildContext context) {
    person = ModalRoute.of(context)?.settings.arguments as Person;
    print('SecondPage build()');
    return Scaffold(
      appBar: AppBar(title: Text('SecondPage')),
       body: Container(
        color: Colors.green,
         child: Text('${person?.name}, ${person?.age}'),
       ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          Navigator.pop(context,'잘 전달됨');
        },
        child: Text('이전 페이지로'),
      ),
    );
  }
}
