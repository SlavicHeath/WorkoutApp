import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:workoutpet/forgot_pass.dart';
import 'package:workoutpet/workout.dart';

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

  User(this.email, this.password);
}

var USER_SAMPLE = [
  User(
    "firstSecond@gmail.com",
    "Password1234",
  ), //correct sample
  User(
    "",
    "Password1234",
  ), //Missing email
  User(
    "firstSecond@gmail.com",
    "",
  ), //Missing Password
  User("firstSecond@gmail.com",
      "1234"), //Password too short must be 8 characters
  User(
    "",
    "",
  ), //Missing all fields
  User("12345", "pass123") //Incorrect email
];

///
/// [LoginScreen.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		StatefulWidget]
/// [@global]
///
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

///
/// [_LoginScreenState.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		State]
/// [@global]
///
class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  String? error;
  final _formKey = GlobalKey<FormState>();
  var character = FirebaseFirestore.instance
      .collection('users')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      print(doc["character"]);
    });
  });
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in Page"),
        backgroundColor: Colors.purple,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Container(
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //       image: AssetImage(""), fit: BoxFit.cover),
              // ),
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
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
                      TextFormField(
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Enter a password"),
                          obscureText: true,
                          onChanged: (value) => password = value,
                          validator: (value) {
                            if (value == null || value.length < 8) {
                              return 'Your password must contain at least 8 characters.';
                            }
                            return null; // Returning null means "no issues"
                          }),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // This calls all validators() inside the form for us.
                            tryLogin();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 40),
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text('Login'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                //The right side is the widget you want to go to
                                builder: (context) => const ForgotPassword()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 40),
                          backgroundColor: Colors.purple,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text("Forgot Password"),
                      ),
                      if (error != null)
                        Text(
                          "Error: $error",
                          style:
                              TextStyle(color: Colors.red[800], fontSize: 12),
                        )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> tryLogin() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email!, password: password!);
      final snackbar = SnackBar(
        content: Text("Logged in as ${credential.user?.email}"),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);

      print("Logged in as ${credential.user}");
      error = null; // clear the error message if exists.
      setState(() {}); // Call setState to trigger a rebuild

      // Check to use the Navigator in an async method.
      if (!mounted) return;

      // pop the navigation stack so people cannot "go back" to the login screen after log in
      Navigator.of(context).pop();
      // set up an if statement to see if they picked a character
      // normally go to workout page
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const WorkoutPage(),
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
      setState(() {
        isLoading = false;
      });
    }
  }
}
