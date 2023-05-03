import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workoutpet/workout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'About.dart';
import 'battle.dart';
import 'main.dart';
import 'personal.dart';

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
        title: const Text("Change Character"),
        backgroundColor: Colors.purple,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer header telling which user is signed in
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.purple),
              child: Text(
                "Signed in as: ${FirebaseAuth.instance.currentUser?.email}",
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(
                    context); //To close the drawer wwhen moving to the next page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const WorkoutPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text("Battle"),
              onTap: () {
                Navigator.pop(
                    context); //To close the drawer wwhen moving to the next page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UserStatsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.swap_horizontal_circle),
              title: const Text("Change Character"),
              onTap: () {
                Navigator.pop(
                    context); //To close the drawer wwhen moving to the next page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CharacterReselect(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_accessibility),
              title: const Text("Change BMI"),
              onTap: () {
                Navigator.pop(
                    context); //To close the drawer wwhen moving to the next page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PersonalInfoPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text("About"),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DescriptionPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text("Signout"),
              onTap: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
            ),
          ],
        ),
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
            buildIndicator2(),

            // button to go to next page
            const SizedBox(height: 20),
            ElevatedButton(
              //assign character to user
              onPressed: () {
                _submitCharacter2(
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
      color: Colors.transparent,
      child: ModelViewer(
        src: displayFile,
      ),
    );
  }

// Switching characters indicator
  Widget buildIndicator2() {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: dislplayFile.length,
      effect: const SlideEffect(activeDotColor: Colors.purple),
    );
  }
}

_submitCharacter2(String displayFile, String displayFile2, String displayFile3,
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
