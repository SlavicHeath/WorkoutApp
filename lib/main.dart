import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:workoutpet/sign_in.dart';
import 'package:workoutpet/signup.dart';
import 'battle.dart';
import 'firebase_options.dart';

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
            ]),
          ),
        ));
  }
}
