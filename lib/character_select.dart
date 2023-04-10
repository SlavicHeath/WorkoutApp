import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workoutpet/personal.dart';
import 'package:workoutpet/sign_in.dart';
import 'package:workoutpet/workout.dart';

class DsiplayTest extends StatefulWidget {
  const DsiplayTest({super.key});

  @override
  State<DsiplayTest> createState() => _DsiplayTestState();
}

class _DsiplayTestState extends State<DsiplayTest> {
  int activeIndex = 0;
  final dislplayFile = [
    'assets/character/Astronaut.glb',
    'assets/character/Astronaut1.glb',
    'assets/character/Astronaut2.glb',
    'assets/character/Astronaut3.glb',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Model Test"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black87),
              child: Text("Profile"),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(
                    context); //To close the drawer wwhen moving to the next page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DsiplayTest(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text("About"),
              onTap: () {
                Navigator.pop(
                    context); //To close the drawer wwhen moving to the next page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WorkoutPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text("Signup/Login"),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
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
                _submitCharacter(dislplayFile[activeIndex]);

                Navigator.of(context).push(
                  MaterialPageRoute(
                      //The right side is the widget you want to go to
                      builder: (context) => PersonalInfoPage()),
                );
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
  final character = <String, dynamic>{
    "user": authUser?.uid,
    "character": displayFile
  };

  if (authUser != null) {
    await FirebaseFirestore.instance
        .collection('character')
        .doc(authUser.uid)
        .set(character);
  }
}
