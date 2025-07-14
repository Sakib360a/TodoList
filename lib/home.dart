import 'package:flutter/material.dart';
import 'package:todo_list/Navbar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
        backgroundColor: Colors.orangeAccent,
        shadowColor: Colors.black,
        elevation: 5,
      ),
    );
  }
}
