import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:workoutpet/main.dart';
import 'package:firebase_database/firebase_database.dart';

// ignore: deprecated_member_use
final databaseReference = FirebaseDatabase.instance.reference();

// ignore: non_constant_identifier_names
void writeUserData(Double Weight, Double Height, Double BMI) {
  databaseReference.child('users').push().set({
    'Weight': Weight,
    'Height': Height,
    'BMI': BMI,
  });
}

class PersonalInfoPage extends StatefulWidget {
  const PersonalInfoPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final _formKey = GlobalKey<FormState>();
  // ignore: prefer_final_fields
  TextEditingController _weightController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _heightController = TextEditingController();
  double _bmiResult = 0.0;

  void _calculateBMI() {
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    double height = double.tryParse(_heightController.text) ?? 0.0;

    if (weight <= 0 || height <= 0) {
      setState(() {
        _bmiResult = 0.0;
      });
      return;
    }

    double bmi = (weight * 703) / (height * height);
    setState(() {
      _bmiResult = bmi;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Information'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                decoration: const InputDecoration(
                  labelText: 'Height (inch)',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _calculateBMI();
                  }
                  () => writeUserData(_heightController as Double, _weightController as Double, _bmiResult as Double);
                },
                // ignore: prefer_const_constructors
                child: Text('Calculate BMI'),
              ),
              // ignore: prefer_const_constructors
              SizedBox(height: 16.0),
              Text(
                _bmiResult == 0.0
                    ? 'Please enter your weight and height'
                    : 'Your BMI is ${_bmiResult.toStringAsFixed(1)}',
                // ignore: prefer_const_constructors
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 // fi
 //nal PerosonalUser = <String, String>{
 // "Weight": _weightController.text,
 // "Height": _heightController.text,
 // "BMI": _bmiResult
//};

//db
  //  .collection("PersonalUser")
  //  .doc("Weight")
  //  .set(Weight)
  //  .onError((e, _) => print("Error writing document: $e"));
//