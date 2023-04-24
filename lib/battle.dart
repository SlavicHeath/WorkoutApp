//Ben Williams

import 'package:firebase_auth/firebase_auth.dart';
import 'package:workoutpet/About.dart';
import 'package:workoutpet/main.dart';
import 'package:workoutpet/personal.dart';
import 'package:workoutpet/workout.dart';
import 'dart:math';
import 'bot.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const documentId =
    'tSfDrDxGjioQnaTuDOrA'; //Change this to a valid document Id in the Battles collection

///[Battle] Object used to map stats from Battles documents.
class Battle {
  int userCurHealth;
  int userStrength;
  int userSpeed;
  int botCurHealth;
  int botStrength;
  int botSpeed;
  int turn;

  Battle(
      {required this.userCurHealth,
      required this.userStrength,
      required this.userSpeed,
      required this.botCurHealth,
      required this.botStrength,
      required this.botSpeed,
      required this.turn});

  ///[fromJson] Creates [Battle] object by maping data from a Battles document [json] to appropriate variables
  static Battle fromJson(Map<String, dynamic> json) => Battle(
      userCurHealth: json['userCurHealth'],
      userStrength: json['userStrength'],
      userSpeed: json['userSpeed'],
      botCurHealth: json['botCurHealth'],
      botStrength: json['botStrength'],
      botSpeed: json['botSpeed'],
      turn: json['turn']);
}

///[initBattle] Creates a battle by initializing data of a Battles documents based on the [userStats]
void initBattle(BattleCharacter userStats) {
  Bot botStats = Bot(userStats.health, userStats.strength, userStats.speed);
  FirebaseFirestore.instance.collection('Battles').add({
    'userCurHealth': userStats.health,
    'userStrength': userStats.strength,
    'userSpeed': userStats.speed,
    'botCurHealth': botStats.health,
    'botStrength': botStats.strength,
    'botSpeed': botStats.speed,
    'turn': 0,
  });
}

///[Workout] Object used to map data from 'workout information' database
class Workout {
  final int reps;
  final int sets;
  final int weight;

  Workout({required this.reps, required this.sets, required this.weight});

  ///[fromJson] Creates [Workout] object by maping data from a 'workout information' document [json] to appropriate variables
  static Workout fromJson(Map<String, dynamic> json) =>
      Workout(reps: json['reps'], sets: json['sets'], weight: json['weight']);
}

///[readWorkouts] Creates a Stream object by maping data from 'workout information' documents to a list of Workout objects
Stream<List<Workout>> readWorkouts() => FirebaseFirestore.instance
    .collection('workout information')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Workout.fromJson(doc.data())).toList());

///[readBattle] Creates a Stream object by maping data from a Battles document to a list of Workout objects
Stream<Battle> readBattle() => FirebaseFirestore.instance
    .collection('Battles')
    .doc(documentId)
    .snapshots()
    .map((DocumentSnapshot<Map<String, dynamic>> snapshot) =>
        Battle.fromJson(snapshot.data()!));

///[updateHealth] Updates both the user's and bot's current health fields of a Battles document with the id matching [docId]
void updateHealth(docId, userHealth, botHealth) {
  final battleDoc = FirebaseFirestore.instance.collection('Battles').doc(docId);
  battleDoc.update({
    'userCurHealth': userHealth,
    'botCurHealth': botHealth,
  });
}

///[updateTurn] Updates the turn field of a Battles document with the id matching [docId]
void updateTurn(docId, turn) {
  final battleDoc = FirebaseFirestore.instance.collection('Battles').doc(docId);
  battleDoc.update({
    'turn': turn,
  });
}

///[deleteDoc] Deletes a document from the Battles collection that posses the id [docId]
void deleteDoc(docId) {
  final battleDoc = FirebaseFirestore.instance.collection('Battles').doc(docId);
  battleDoc.delete();
}

///[calcStats] Calculates the health, strength, and speed of a user based on a list of [Workout] objects
BattleCharacter calcStats(List<Workout> workoutList) {
  BattleCharacter temp = BattleCharacter(0, 0, 0);
  workoutList.forEach((workout) {
    temp.health += workout.weight;
    temp.strength += workout.reps;
    temp.speed += workout.sets;
  });
  return temp;
}

class UserStatsScreen extends StatefulWidget {
  const UserStatsScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _UserStatsScreen createState() => _UserStatsScreen();
}

class _UserStatsScreen extends State<UserStatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User\'s Battle Stats'),
          backgroundColor: Colors.purple,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.black87),
                child: Text(
                  "Signed in as: ${FirebaseAuth.instance.currentUser?.email}",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
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
                leading: Icon(Icons.list),
                title: Text("Battle"),
                onTap: () {
                  Navigator.pop(
                      context); //To close the drawer wwhen moving to the next page
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserStatsScreen(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text("Personal Information"),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => PersonalInfoPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.list),
                title: Text("About"),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => DescriptionPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.login),
                title: Text("Signout"),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: StreamBuilder<List<Workout>>(
                stream: readWorkouts(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Database Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    final workouts = snapshot.data!;
                    BattleCharacter userStats = calcStats(workouts);
                    int userHealth = userStats.health;
                    int userStrength = userStats.strength;
                    int userSpeed = userStats.speed;
                    return Column(
                      children: <Widget>[
                        Text('HEALTH',
                            style: TextStyle(
                              letterSpacing: 2.0,
                            )),
                        SizedBox(height: 10.0),
                        Text('$userHealth',
                            style: TextStyle(
                              letterSpacing: 2.0,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            )),
                        SizedBox(height: 20.0),
                        Text('STRENGTH',
                            style: TextStyle(
                              letterSpacing: 2.0,
                            )),
                        SizedBox(height: 10.0),
                        Text('$userStrength',
                            style: TextStyle(
                              letterSpacing: 2.0,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            )),
                        SizedBox(height: 20.0),
                        Text('SPEED',
                            style: TextStyle(
                              letterSpacing: 2.0,
                            )),
                        SizedBox(height: 10.0),
                        Text('$userSpeed',
                            style: TextStyle(
                              letterSpacing: 2.0,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            )),
                        ElevatedButton(
                          onPressed: () {
                            initBattle(userStats);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BattlePreviewScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 40),
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text("Find Opponent"),
                        ),
                      ],
                    );
                  } else {
                    //if database is being loaded
                    return Center(child: CircularProgressIndicator());
                  }
                }),
          ),
        ));
  }
}

class BattlePreviewScreen extends StatefulWidget {
  const BattlePreviewScreen({super.key});
  @override
  _BattlePreviewScreenState createState() => _BattlePreviewScreenState();
}

class _BattlePreviewScreenState extends State<BattlePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battle Preview'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<Battle>(
            stream: readBattle(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Database Error: ${snapshot.error}");
              } else if (snapshot.hasData) {
                final curBattle = snapshot.data!;
                int userCurHealth = curBattle.userCurHealth;
                int userStrength = curBattle.userStrength;
                int userSpeed = curBattle.userSpeed;
                int botCurHealth = curBattle.botCurHealth;
                int botStrength = curBattle.botStrength;
                int botSpeed = curBattle.botSpeed;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: Text('HEALTH',
                              style: TextStyle(
                                letterSpacing: 2.0,
                              )),
                        ),
                        Expanded(
                          child: Text('HEALTH',
                              style: TextStyle(
                                letterSpacing: 2.0,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: SizedBox(height: 10.0)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text('$userCurHealth',
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              )),
                        ),
                        Expanded(
                          child: Text('$botCurHealth',
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: SizedBox(height: 20.0)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text('STRENGTH',
                              style: TextStyle(
                                letterSpacing: 2.0,
                              )),
                        ),
                        Expanded(
                          child: Text('STRENGTH',
                              style: TextStyle(
                                letterSpacing: 2.0,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: SizedBox(height: 10.0)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text('$userStrength',
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              )),
                        ),
                        Expanded(
                          child: Text('$botStrength',
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: SizedBox(height: 20.0)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text('SPEED',
                              style: TextStyle(
                                letterSpacing: 2.0,
                              )),
                        ),
                        Expanded(
                          child: Text('SPEED',
                              style: TextStyle(
                                letterSpacing: 2.0,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(child: SizedBox(height: 10.0)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text('$userSpeed',
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              )),
                        ),
                        Expanded(
                          child: Text('$botSpeed',
                              style: TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 28.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 40),
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text("Back"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BattleScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 40),
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text("Fight"),
                        ),
                      ],
                    ),
                  ],
                );
              } else {
                //if database is being loaded
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

class BattleScreen extends StatefulWidget {
  const BattleScreen({super.key});
  @override
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  String _turnButtonText = "Next Turn";
  String _logText = "";
  var _logColor = Colors.green;
  void action(Battle curBattle) {
    var rand = new Random();
    if (curBattle.turn % 2 == 0) {
      if (rand.nextInt(100) < curBattle.botSpeed) {
        setState(() {
          _logColor = Colors.green;
          _logText = "User misses enemy";
        });
      } else {
        curBattle.botCurHealth -= curBattle.userStrength;
        setState(() {
          _logColor = Colors.green;
          _logText = "User hits enemy for ${curBattle.userStrength} damage";
        });
      }
    } else {
      if (rand.nextInt(100) < curBattle.userSpeed) {
        setState(() {
          _logColor = Colors.red;
          _logText = "Enemy misses user";
        });
      } else {
        curBattle.userCurHealth -= curBattle.botStrength;
        setState(() {
          _logColor = Colors.red;
          _logText = "Enemy hits user for ${curBattle.botStrength} damage";
        });
      }
    }
    if (curBattle.botCurHealth <= 0) {
      setState(() {
        _turnButtonText = "The User Has Won!!!";
      });
    }
    if (curBattle.userCurHealth <= 0) {
      setState(() {
        _turnButtonText = "The Enemy Has Won :(";
      });
    }
    updateHealth(documentId, curBattle.userCurHealth, curBattle.botCurHealth);
    curBattle.turn++;
    updateTurn(documentId, curBattle.turn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Battle Preview'),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.purple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<Battle>(
              stream: readBattle(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Database Error: ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final curBattle = snapshot.data!;
                  int userCurHealth = curBattle.userCurHealth;
                  int userStrength = curBattle.userStrength;
                  int userSpeed = curBattle.userSpeed;
                  int botCurHealth = curBattle.botCurHealth;
                  int botStrength = curBattle.botStrength;
                  int botSpeed = curBattle.botSpeed;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Text('HEALTH',
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                )),
                          ),
                          Expanded(
                            child: Text('HEALTH',
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: SizedBox(height: 10.0)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text('$userCurHealth',
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                )),
                          ),
                          Expanded(
                            child: Text('$botCurHealth',
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: SizedBox(height: 20.0)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text('STRENGTH',
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                )),
                          ),
                          Expanded(
                            child: Text('STRENGTH',
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: SizedBox(height: 10.0)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text('$userStrength',
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                )),
                          ),
                          Expanded(
                            child: Text('$botStrength',
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: SizedBox(height: 20.0)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text('SPEED',
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                )),
                          ),
                          Expanded(
                            child: Text('SPEED',
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: SizedBox(height: 10.0)),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text('$userSpeed',
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                )),
                          ),
                          Expanded(
                            child: Text('$botSpeed',
                                style: TextStyle(
                                  letterSpacing: 2.0,
                                  fontSize: 28.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                )),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(_logText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: _logColor,
                              )),
                        ),
                      ),
                      Expanded(
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                onPressed: () {
                                  if ((userCurHealth <= 0) |
                                      (botCurHealth <= 0)) {
                                    deleteDoc(documentId);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HomeScreen()),
                                    );
                                  } else {
                                    action(curBattle);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(200, 40),
                                  backgroundColor: Colors.purple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(_turnButtonText),
                              )))
                    ],
                  );
                } else {
                  //if database is being loaded
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ));
  }
}
