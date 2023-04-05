import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
            const SizedBox(height: 32),
            buildIndicator(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print(dislplayFile[activeIndex]);
                Navigator.of(context).push(
                  MaterialPageRoute(
                      //The right side is the widget you want to go to
                      builder: (context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 40),
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text("Battle Screen"),
            ),
          ],
        ),
      ),
    );
  }

  // Display the 3d Model on screen
  Widget buildImage(String displayFile, int index) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 10),
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
