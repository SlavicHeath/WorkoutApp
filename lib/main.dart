import 'package:flutter/material.dart';
import 'package:workoutpet/personal.dart';


void main() {
  runApp(const MaterialApp(title: "WorkoutPet", home: HomeScreen()));
}

class HomeScreen extends StatelessWidget {
    const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WorkoutPet"),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(""), fit: BoxFit.cover),
        // ),
        child: Center(

          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [

          
            // Create button
            ElevatedButton(
              onPressed: () {
                // Pushes on a stack for back arrow button to form
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      //The right side is the widget you want to go to

                      builder: (context) => const PersonalInfoPage()),

                  

                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 40),
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),

              child: const Text("Personal Information"),

            )
          ])
        ),
      )
    );
  }
}