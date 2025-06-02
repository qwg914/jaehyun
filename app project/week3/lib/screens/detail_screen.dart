import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String content;

  const DetailScreen({required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('전체 뉴스 보기')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Text(content, style: TextStyle(fontSize: 16)),
      ),
    );
  }
}
