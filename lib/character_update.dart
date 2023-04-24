import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:workoutpet/battle.dart';
import 'package:workoutpet/workout.dart';

String displayFile = 'assets/character/Astronaut.glb';
String displayFile1 = 'assets/character/exampleDuck.glb';
String displayFile2 = 'assets/character/exampleOctopus.glb';
String displayFile3 = 'assets/character/examplePanda.glb';
int xp = 700;

class character_update extends StatelessWidget {
  const character_update({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 300,
      margin: EdgeInsets.symmetric(horizontal: 10),
      color: Colors.grey,
      child: ModelViewer(
        src: _updateModel(),
        alt: "A 3D model",
        ar: true,
        autoRotate: true,
        cameraControls: true,
      ),
    );
  }
}

_updateModel() {
  if ((xp >= 0) && (xp < 200) && (displayFile == displayFile)) {
    return displayFile;
  } else if ((xp >= 200) && (xp < 400)) {
    return displayFile1;
  } else if ((xp >= 400) && (xp < 600)) {
    return displayFile2;
  } else if ((xp >= 600) && (xp < 1000)) {
    return displayFile3;
  }
}

class PeopleList extends StatelessWidget {
  PeopleList({super.key});

  // Reference to the Firestore "People" collection
  final modelRef = FirebaseFirestore.instance
      .collection('Character')
      .where(documentId, isEqualTo: authUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: modelRef, //.snapshots() gives us a Stream
      builder: (context, snapshot) {
        // Make sure that the snapshot has data with it.
        // There may be no data while the network connection is initializing.
        // And sometimes the data is empty, like and empty street.
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text("No data to show!");
        }

        // Here is the list of Documents from the People collection.
        var modeldoc = snapshot.data!.docs.map((e) => null);
        // Use a ListView.builder to generate a ListView
        // to display the People collection
        return ListView.builder(
          itemCount: modeldoc.length,
          itemBuilder: ((context, index) {
            return Text('${modeldoc.first}');
          }),
        );
        // return TextFormField(
        //   decoration: const InputDecoration(
        //       border: UnderlineInputBorder(),
        //       labelText: "${modeldoc.get('Character')}"),
        // );
      },
    );
  }
}
