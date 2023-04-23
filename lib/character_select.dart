import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workoutpet/personal.dart';
import 'package:workoutpet/sign_in.dart';
import 'package:workoutpet/workout.dart';

class CharacterSelect extends StatefulWidget {
  const CharacterSelect({super.key});

  @override
  State<CharacterSelect> createState() => _CharacterSelectState();
}

class _CharacterSelectState extends State<CharacterSelect> {
  int activeIndex = 0;
  // create a read from the database bmi section
  var bmi = FirebaseFirestore.instance
      .collection('users')
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      print(doc["bmi"]);
    });
  });

  final dislplayFile = [
    'assets/character/balloon1.glb',
    'assets/character/dolphin1.glb',
    'assets/character/turtle1.glb',
    'assets/character/balloon2.glb',
    'assets/character/balloon3.glb',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Model Test"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CarouselSlider.builder(
              itemCount: dislplayFile.length,
              itemBuilder: (context, index, realIndex) {
                final displayFile = dislplayFile[index];
                return buildImage(displayFile, index);
              },
              options: CarouselOptions(
                height: 500,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(
                    () {
                      activeIndex = index;
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // build character
            buildIndicator(),

            // button to go to next page
            const SizedBox(height: 20),
            ElevatedButton(
              //assign character to user
              onPressed: () {
                if (bmi == Null) {
                  _submitCharacter(dislplayFile[activeIndex]);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        //no bmi go to personal page
                        builder: (context) => const PersonalInfoPage()),
                  );
                } else {
                  _submitCharacter(dislplayFile[activeIndex]);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        //bmi go to main page
                        builder: (context) => const WorkoutPage()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 40),
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text("Select and go to the next Screen"),
            ),
          ],
        ),
      ),
    );
  }

  // Display the 3d Model on screen
  Widget buildImage(String displayFile, int index) {
    return Container(
      height: 20,
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.grey,
      child: ModelViewer(
        src: displayFile,
        alt: "A 3D model of an astronaut",
        ar: true,
        autoRotate: true,
        cameraControls: true,
      ),
    );
  }

// Switching characters indicator
  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: dislplayFile.length,
      effect: SlideEffect(activeDotColor: Colors.purple),
    );
  }
}

_submitCharacter(String displayFile) async {
  final authUser = await FirebaseAuth.instance.currentUser;
  final character = <String, dynamic>{"character": displayFile};

  if (authUser != null) {
    await FirebaseFirestore.instance
        .collection('character')
        .doc(authUser.uid)
        .set(character);
  }
}
