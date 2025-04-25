import 'package:flutter/material.dart';
import 'package:lifecycle/second_page.dart';
import 'package:lifecycle/person.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('FirstPage build()');
    return Scaffold(
      appBar: AppBar(title: Text('FirstPage')),
      body: Container(
        color: Colors.red,
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          final person = Person('홍길동', 30);

           var result = await Navigator.push(
             context,
             MaterialPageRoute(builder: (context) => SecondPage(person: person))
           );
        },
        child: Text('다음 페이지로'),
      ),
    );
  }
}
