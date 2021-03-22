import 'package:flutter/material.dart';
import 'package:intern/apicall.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Internship app',
      home: apicall(),
    );
  }
}