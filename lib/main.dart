import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workoutpet/sign_in.dart';
import 'package:workoutpet/signup.dart';
import 'firebase_options.dart';

///
/// [@var		object	async]
/// [@global]
///
void main() async {
  runApp(const MaterialApp(title: "WorkoutPet", home: HomeScreen()));
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
  const HomeScreen({super.key});
  //final authUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage("assets/character/background.png"),
        fit: BoxFit.fill,
      )),
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Create button
          ElevatedButton(
            onPressed: () {
              // Pushes on a stack for back arrow button to form
              Navigator.push(
                context,
                MaterialPageRoute(
                    //The right side is the widget you want to go to
                    builder: (context) => const LoginScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 40),
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text("LogIn"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    //The right side is the widget you want to go to
                    builder: (context) => const SignUpScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(200, 40),
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text("SignUp"),
          ),
        ]),
      ),
    ));
  }
}
