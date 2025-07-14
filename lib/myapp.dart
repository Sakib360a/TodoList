import 'package:flutter/material.dart';
import 'home.dart';

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    title: 'ToDo List App',
      home: Home(),
    );
  }
}
