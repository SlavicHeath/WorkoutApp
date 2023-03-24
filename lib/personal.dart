import 'dart:html';
import 'package:flutter/material.dart';
import 'package:workoutpet/main.dart';

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
 // final PerosonalUser = <String, String>{
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
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            // Create button
            ElevatedButton(
              onPressed: () {
                // Pushes on a stack for back arrow button to form
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      //The right side is the widget you want to go to
                      builder: (context) => HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 40),
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text("HomeScreen"),
            )
          ])
        )
      )
    );
  }
}
