import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:workoutpet/workout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///
/// [PersonalInfoPage.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Thursday, March 30th, 2023]
/// [@see		StatefulWidget]
/// [@global]
///
class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

///
/// [_PersonalInfoPageState.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Thursday, March 30th, 2023]
/// [@see		State]
/// [@global]
///
class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _formKey = GlobalKey<FormState>();
  // ignore: prefer_final_fields
  TextEditingController _weightController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _heightController = TextEditingController();
  double bmiResult = 0.0;

  void _calculateBMI() {
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    double height = double.tryParse(_heightController.text) ?? 0.0;

    if (weight <= 0 || height <= 0) {
      setState(() {
        bmiResult = 0.0;
      });
      return;
    }

    double bmi = (weight * 703) / (height * height);
    setState(() {
      bmiResult = bmi;
    });
  }

  final authUser = FirebaseAuth.instance.currentUser;
  final personalInfoRef = FirebaseFirestore.instance.collection('personal');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Personal Information'),
          backgroundColor: Colors.purple,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _weightController,
                      decoration: const InputDecoration(
                        labelText: 'Weight (lbs)',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      autofocus: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your weight';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _heightController,
                      autofocus: true,
                      decoration: const InputDecoration(
                        labelText: 'Height (inch)',
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your height';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    // ignore: prefer_const_constructors
                    SizedBox(height: 16.0),
                    Text(
                      bmiResult == 0.0
                          ? 'Please enter your weight and height'
                          : 'Your BMI is ${bmiResult.toStringAsFixed(1)}',
                      // ignore: prefer_const_constructors
                      style: TextStyle(fontSize: 20.0),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _calculateBMI();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                      ),
                      // ignore: prefer_const_constructors
                      child: Text('Calculate BMI'),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple,
                      ),
                      child: const Text(
                          //User presses this button to submit valid information
                          'SUBMIT'),
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('personal')
                            .doc(authUser?.uid)
                            .set({
                              'weight': _weightController.text,
                              'height': _heightController.text,
                              'bmi': bmiResult
                            })
                            // ignore: avoid_print
                            .then((value) => print("added"))
                            .catchError(
                                // ignore: avoid_print
                                (error) => print("Failed to add: $error"));
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              //The right side is the widget you want to go to
                              builder: (context) => const WorkoutPage()),
                        );
                      },
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('personal')
                            .doc(authUser?.uid)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          Map<String, dynamic> data = {};
                          if (snapshot.data?.data() != null) {
                            data =
                                snapshot.data!.data() as Map<String, dynamic>;
                          }
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Height: ${data['height'] ?? 'N/A'}'),
                                Text('Weight: ${data['weight'] ?? 'N/A'}'),
                                Text('BMI: ${data['bmi'] ?? 'N/A'}'),
                              ]);
                        })
                  ],
                ),
              ),
            )));
  }
}
