import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class DescriptionPage extends StatelessWidget {
  const DescriptionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Description'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // About page
          child: Text(
              "This app is called WorkoutPet.  It was developed by a junior development team for a project in a CSCC-450 at UNCW. The application is a version of a workout app.  When you signup for our app, you will be prompted with a menu that will allow you to choose a character that is animated.  As you workout and go through life, you will input what workouts you do in your evverday life for your body, and you will see that your character will begin to grow over time exactly like you do.  It will then be able to battle other players characters, so over timee as you grow your character, you might be able to completely boss the other characters in the game and might become the strongest character in the world. You are able to input your BMI and watch as your BMI will change over time if you are consistent with yourworkouts. You will be able to see all of the previous workout data that you have for your chracter. This can allow you to easily repeat and do the same workout over and over again.  There is truly nothing that you cannot do with our app in the workout space and it will be a great way to motivate you to hit the Gym and lose some weight. "),
        ),
      ),
    );
  }
}
