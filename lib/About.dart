// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {
  const DescriptionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Description'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("What is this application?", 
            style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
               Text(
             "This app is called WorkoutPet.  It was developed by a junior development team for a project in a CSC-450 at UNCW. When you signup for our app, you will be prompted with a menu that will allow you to choose a character that is animated.  As you workout you will input what workouts you do in your evverday life for your body, and you will see that your character will begin to grow over time exactly like you do. You are able to input your BMI and watch as your BMI will change over time if you are consistent with yourworkouts. You will be able to see all of the previous workout data that you have for your chracter. With working out you can also battle other characters and your strength is based on workouts so workout more and you will win!  ", 
             style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 14),
            Text("Developers", 
            style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 6),
            const ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text("Sawyer Kent")
            ),
            const ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text("Slavic Heath")
            ),
            const ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text("Ryan Lehner")
            ),
            const ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text("Ben Williams")
            ),
            const ListTile(
              leading: Icon(Icons.developer_mode),
              title: Text("Mujuni Mutabiilwa")
            ),
         ]
       ),
      ),
    );
  }
}
