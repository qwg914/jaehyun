import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'Hello World'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _textTop = 'Hello';
  var _textBottom = '';

  void _toggleText() {
    setState(() {
      if (_textTop == 'Hello' && _textBottom == '') {
        _textTop = '';
        _textBottom = 'World';
      } else {
        _textTop = 'Hello';
        _textBottom = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              _textTop,
              style: TextStyle(fontSize: 40),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              _textBottom,
              style: TextStyle(fontSize: 40),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleText,
        tooltip: 'Toggle Text',
        child: const Icon(Icons.add),
      ),
    );
  }
}