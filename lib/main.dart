import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workoutpet/character_update.dart';
import 'package:workoutpet/personal.dart';
import 'package:workoutpet/sign_in.dart';
import 'package:workoutpet/signup.dart';
import 'package:workoutpet/workout.dart';
import 'battle.dart';
import 'character_select.dart';
import 'database_test.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

///
/// [@var		object	async]
/// [@global]
///
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(title: "WorkoutPet", home: HomeScreen()));
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

///
/// [HomeScreen.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		StatelessWidget]
/// [@global]
///
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  //final authUser = FirebaseAuth.instance.currentUser;

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
            ]),
          ),
        ));
  }
}
