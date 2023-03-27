


import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



import 'package:flutter/material.dart';


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
                },
                // ignore: prefer_const_constructors
                child: Text('Calculate BMI'),
              ),
              // ignore: prefer_const_constructors
              SizedBox(height: 16.0),
              Text(
                bmiResult == 0.0
                    ? 'Please enter your weight and height'
                    : 'Your BMI is ${bmiResult.toStringAsFixed(1)}',
                // ignore: prefer_const_constructors
                style: TextStyle(fontSize: 20.0),
              ),
              TextButton(
              child: const Text(
                  //User presses this button to submit valid information
                  'SUBMIT'),
              onPressed: () {
                FirebaseFirestore.instance
                .collection('personal')
                .add({'weight': _weightController.text,
                'height': _heightController.text,
                'bmi': bmiResult})
                .then((value) => print("added"))
                .catchError((error) => print("Failed to add: $error"));
                //addPersonalData(_weightController.text.trim(), _heightController.text.trim(), bmiResult.toString());
                
              },
              )
            ], 
          ),
        ),
      ),
    );
  }
}



class personal {
  double personalWeight;
  double personalHeight;
  personal(this.personalWeight, this.personalHeight);
}



CollectionReference personal1 = FirebaseFirestore.instance.collection('Personal information');

 //Creates the addpersonalData Method to add personal
addPersonalData(String weight, String height,String bmi) async {
  await FirebaseFirestore.instance.collection('users').add({
    'Weight': weight,
    'Height': height,
    'BMI': bmi
  });
}

