import 'package:flutter/material.dart';

class PrevWorkPage extends StatefulWidget {
  const PrevWorkPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _PrevWorkPageState createState() => _PrevWorkPageState();
}

class _PrevWorkPageState extends State<PrevWorkPage> {
  final _formKey = GlobalKey<FormState>();

  // ignore: prefer_final_fields
  TextEditingController _weightController = TextEditingController();
  // ignore: prefer_final_fields
  TextEditingController _heightController = TextEditingController();

  void _calculateBMI() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PREVIOUS WORKOUTS'),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
