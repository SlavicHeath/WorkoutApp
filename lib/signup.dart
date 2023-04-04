import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workoutpet/sign_in.dart';

import 'main.dart';

///
/// [User.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@global]
///
class User {
  String email;
  String password;
  String passrepeat;

  User(this.email, this.password, this.passrepeat);
}

var USER_SAMPLE = [
  User(
      "firstSecond@gmail.com", "Password1234", "Password1234"), //correct sample
  User("", "Password1234", "Password1234"), //Missing email
  User("firstSecond@gmail.com", "", ""), //Missing Password
  User("firstSecond@gmail.com", "1234",
      "1234"), //Password too short must be 8 characters
  User("firstSecond@gmail.com", "1234", ""), //Missing password repeat
  User("", "", ""), //Missing all fields
  User("12345", "pass123", "pass123") //Incorrect email
];

///
/// [SignUpScreen.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		StatefulWidget]
/// [@global]
///
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

///
/// [_SignUpScreenState.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		State]
/// [@global]
///
class _SignUpScreenState extends State<SignUpScreen> {
  String? email;
  String? password;
  String? error;
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up Page"),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(""), fit: BoxFit.cover),
        // ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Email Field
                TextFormField(
                    // Prompt user to enter email
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter your email'),
                    maxLength: 64,
                    onChanged: (value) => email = value,
                    validator: (value) {
                      // Check for blank email
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email text';
                      }
                      return null;
                    }),
                // Field for password
                TextFormField(
                    controller: _pass,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter a password"),
                    obscureText: true,
                    onChanged: (value) => password = value,
                    validator: (value) {
                      // if password entered less than 8 or blank
                      if (value == null || value.length < 8) {
                        return 'Your password must contain at least 8 characters.';
                      }
                      return null;
                    }),
                // Repeat Password Field
                TextFormField(
                    controller: _confirmPass,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter a password again"),
                    obscureText: true,
                    onChanged: (value) => password = value,
                    validator: (value) {
                      // Must match previous password and cannot be empty
                      if (value != _pass.text || value == null) {
                        return 'Your passwords must match!';
                      }
                      return null; // Returning null means "no issues"
                    }),
                // Button to submit enterd data
                ElevatedButton(
                    child: const Text('Sign Up'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // This calls all validators() inside the form for us.
                        trySignUp();
                      }
                    }),
                // Return to Home Screen if account already exist
                ElevatedButton(
                    child: const Text('Already have account - LogIn'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    }),
                // Check all errors
                if (error != null)
                  Text(
                    "Error: $error",
                    style: TextStyle(color: Colors.red[800], fontSize: 12),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Note the async keyword
  // Connection and testing for users from database
  void trySignUp() async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      //When loged in present user logged in
      print("Logged in ${credential.user}");
      error = null; // clear the error message if exists.
      setState(() {}); // Call setState to trigger a rebuild

      // Check if login Screen is visible
      if (!mounted) return;

      // pop the navigation stack so people cannot "go back" to the login screen
      // after logging in.
      Navigator.of(context).pop();
      // Go to the HomeScreen.
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ));
    }
    // Check data base for errors such as wrong password or email
    on FirebaseAuthException catch (e) {
      // Exceptions are raised if the Firebase Auth service
      // encounters an error. We need to display these to the user.
      if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided for that user.';
      } else {
        error = 'An error occurred: ${e.message}';
      }

      // Call setState to redraw the widget, which will display
      // the updated error text.
      setState(() {});
    }
  }
}
