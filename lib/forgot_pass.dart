import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workoutpet/sign_in.dart';

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
  User(this.email);
}

///
/// [@var		array	USER_SAMPLE]
/// [@global]
///
var USER_SAMPLE = [
  User("firstSecond@gmail.com"), //correct sample
  User(""), // No values entered
  User("daswerfwe"), //Incorrect email
];

///
/// [ForgotPassword.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		StatefulWidget]
/// [@global]
///
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

///
/// [_ForgotPassword.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		State]
/// [@global]
///
class _ForgotPassword extends State<ForgotPassword> {
  String? email;
  String? error;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
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
                      passwordReset();
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

  ///
  /// [@var		object	async]
  ///
  void passwordReset() async {
    try {
      final credential = await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email.toString());
      const snackbar = SnackBar(
        content: Text("Email sent"),
        backgroundColor: Colors.green,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
      print("Email Sent to ${email}");
      error = null; // clear the error message if exists.
      setState(() {}); // Call setState to trigger a rebuild

      // // Check to use the Navigator in an async method.
      if (!mounted) return;

      // pop the navigation stack so people cannot "go back" to the login screen after log in
      Navigator.of(context).pop();
      // Now go to the HomeScreen.
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ));
    } on FirebaseAuthException catch (e) {
      // Exceptions are raised if the Firebase Auth service
      // encounters an error. We need to display these to the user.
      if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
      } else {
        error = 'An error occurred: ${e.message}';
      }

      // Call setState to redraw the widget, which will display
      // the updated error text.
      setState(() {});
    }
  }
}
