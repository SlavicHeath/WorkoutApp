import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///
/// [DataWrite.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		StatelessWidget]
/// [@global]
///
class DataWrite extends StatelessWidget {
  const DataWrite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Database"),
      ),
      body: Center(
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            //Values can be data collected from user replacing 160 by user input on button click
            FirebaseFirestore.instance
                .collection('personal')
                .add({'weight': 160})
                .then((value) => print("added"))
                .catchError((error) => print("Failed to add: $error"));
          },
        ),
      ),
    );
  }
}

///
/// [DataRead.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		StatelessWidget]
/// [@global]
///
class DataRead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read Data"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Pet').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Container(
                child: Center(child: Text(document['accessories'])),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
