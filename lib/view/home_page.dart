import 'package:flutter/material.dart';
import '../view/quizz_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil"),
        backgroundColor: Colors.grey[850],
      ),
      body: Center(
        child: TextButton(
           style: TextButton.styleFrom(
            minimumSize: const Size(100, 80),
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            backgroundColor: Colors.grey[850],
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const QuizzPage()),
            );
          },
          child: const Text(
            "Commencer le quizz",
            style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    ),
    );
  }
}
