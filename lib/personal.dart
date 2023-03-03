import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Personal {
    double PersonalWeight;
    double PersonalHeight;
    Personal(this.PersonalWeight,this.PersonalHeight);

}

var personal_sample = [
  Personal(155.5 , 70), // sample of personal data that is correct

  Personal(130, 6), // sample of personal data that is incorrect by including feeet and inches

  Personal(5.5, 60), // sample of personal data that is imcomplete

  Personal(45, 0), //sample of personal data that is incomplete

  Personal(5, 5), //Sample of data with both fields that are incomplete
];

class PersonalPage extends StatefulWidget {
  @override
  NewPersonalPageState createState() => NewPersonalPageState();
}

class NewPersonalPageState extends State<NewPersonalPage> {
  final formKey = GlobalKey<FormState>();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
}

void _submit() async  {
    if (formKey.currentState!.validate()) {
    final weight = double.parse(weightController.text);
    final height = double.parse(heightController.text);
    final bmi = weight / (weight * height);




    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text('BMI Calculation');
        content: Text('After entering your height and weight your BMI is ${NumberFormat('0.0').format(bmi)}'),
      ))
  }
}
@override
  Widget build(BuildContext context) {
    return Scaffold(