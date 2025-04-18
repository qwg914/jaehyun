import 'package:flutter/material.dart';
import 'package:lifecycle/first_page.dart';
import 'package:lifecycle/second_page.dart';
import 'package:lifecycle/person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FirstPage(),

      //
      onGenerateRoute: (settings) {
        if (settings.name == '/second') {
          final person = settings.arguments as Person;
          return MaterialPageRoute(
            builder: (context) => SecondPage(person: person),
          );
        }
        return null;
      },

    );
  }
}