import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workoutpet/workout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CharacterReselect extends StatefulWidget {
  const CharacterReselect({super.key});

  @override
  State<CharacterReselect> createState() => _CharacterReselectState();
}

class _CharacterReselectState extends State<CharacterReselect> {
  int activeIndex = 0;
  // create a read from the database bmi section

  final dislplayFile = [
    'assets/character/balloon1.glb',
    'assets/character/dolphin1.glb',
    'assets/character/turtle1.glb',
    'assets/character/duck1.glb',
    'assets/character/bearbear1.glb',
  ];
  final displayFile2 = [
    'assets/character/balloon2.glb',
    'assets/character/dolphin2.glb',
    'assets/character/turtle2.glb',
    'assets/character/duck2.glb',
    'assets/character/bearbear2.glb',
  ];
  final displayFile3 = [
    'assets/character/balloon3.glb',
    'assets/character/dolphin3.glb',
    'assets/character/turtle3.glb',
    'assets/character/duck3.glb',
    'assets/character/bearbear3.glb',
  ];
  final displayFile4 = [
    'assets/character/balloon4.glb',
    'assets/character/dolphin4.glb',
    'assets/character/turtle4.glb',
    'assets/character/duck4.glb',
    'assets/character/bearbear4.glb',
  ];
  final displayFile5 = [
    'assets/character/balloon5.glb',
    'assets/character/dolphin5.glb',
    'assets/character/turtle5.glb',
    'assets/character/duck5.glb',
    'assets/character/bearbear5.glb',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Model Test"),
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
                height: 250,
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
                _submitCharacter(
                    dislplayFile[activeIndex],
                    displayFile2[activeIndex],
                    displayFile3[activeIndex],
                    displayFile4[activeIndex],
                    displayFile5[activeIndex]);
                Navigator.of(context).push(
                  MaterialPageRoute(
                      //bmi go to main page
                      builder: (context) => const WorkoutPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(300, 40),
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text("Select and go to the next Screen"),
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
      margin: const EdgeInsets.symmetric(horizontal: 10),
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
      effect: const SlideEffect(activeDotColor: Colors.purple),
    );
  }
}

_submitCharacter(String displayFile, String displayFile2, String displayFile3,
    String displayFile4, String displayFile5) async {
  final authUser = FirebaseAuth.instance.currentUser;
  final character = <String, dynamic>{
    "character": displayFile,
    "character2": displayFile2,
    "character3": displayFile3,
    "character4": displayFile4,
    "character5": displayFile5
  };

  if (authUser != null) {
    await FirebaseFirestore.instance
        .collection('character')
        .doc(authUser.uid)
        .set(character);
  }
}
