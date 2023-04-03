import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workoutpet/personal.dart';
import 'package:workoutpet/sign_in.dart';
import 'package:workoutpet/signup.dart';
import 'package:workoutpet/workout.dart';
import 'battle.dart';
import 'database_test.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(title: "WorkoutPet", home: HomeScreen()));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Create button
              ElevatedButton(
                onPressed: () {
                  // Pushes on a stack for back arrow button to form
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        //The right side is the widget you want to go to
                        builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("LogIn"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        //The right side is the widget you want to go to
                        builder: (context) => SignUpScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("SignUp"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        //The right side is the widget you want to go to
                        builder: (context) => PersonalInfoPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("Personal"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        //The right side is the widget you want to go to
                        builder: (context) => WorkoutPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("Workout"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        //The right side is the widget you want to go to
                        builder: (context) => PrevWorkPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(" Previous Workout"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        //The right side is the widget you want to go to
                        builder: (context) => DataWrite()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("Add Data to Database"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        //The right side is the widget you want to go to
                        builder: (context) => DataRead()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("Read Data to Database"),
              ),
              ElevatedButton(
                onPressed: () {
                  final docNum = FirebaseFirestore.instance
                      .collection('Battles')
                      .doc()
                      .get()
                      .then((DocumentSnapshot documentSnapshot) {
                    if (documentSnapshot.exists) {
                      print(Text("No Docs"));
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => UserStatsScreen()),
                      );
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("Battle Screen"),
              ),
            ]),
          ),
        ));
  }
}
