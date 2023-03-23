import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:workoutpet/main.dart';

class User {
  String email;
  User(this.email);
}

var USER_SAMPLE = [
  User("firstSecond@gmail.com"), //correct sample
  User(""), // No values entered
  User("daswerfwe"), //Incorrect email
];

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  String? email;
  String? password;
  String? error;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in Page"),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(""), fit: BoxFit.cover),
        // ),
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Enter your email'),
                  maxLength: 64,
                  onChanged: (value) => email = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null; // Returning null means "no issues"
                  }),
              const SizedBox(height: 16),
              ElevatedButton(
                  child: const Text('Reset Password'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // This calls all validators() inside the form for us.
                      tryLogin();
                    }
                  }),
              if (error != null)
                Text(
                  "Error: $error",
                  style: TextStyle(color: Colors.red[800], fontSize: 12),
                )
            ],
          ),
        ),
      ),
    );
  }

// Forgot Password

  void tryLogin() async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);

      print("Logged in ${credential.user}");
      error = null; // clear the error message if exists.
      setState(() {}); // Call setState to trigger a rebuild

      // Check to use the Navigator in an async method.
      if (!mounted) return;

      // pop the navigation stack so people cannot "go back" to the login screen after log in
      Navigator.of(context).pop();
      // Now go to the HomeScreen.
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ));
    } on FirebaseAuthException catch (e) {
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
