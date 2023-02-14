import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "WorkoutPet", home: HomeScreen()));
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WorkoutPet"),
        backgroundColor: Colors.purple,
      ),
      body: Column(),
    );
  }
}
