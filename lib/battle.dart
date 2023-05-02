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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workoutpet/battleLog.dart';
import 'dart:async';

///[Battle] Object used to map stats from Battles documents.
class Battle {
  int userCurHealth;
  int userMaxHealth;
  int userStrength;
  int userSpeed;
  int botCurHealth;
  int botMaxHealth;
  int botStrength;
  int botSpeed;
  int turn;
  String log;

  Battle({
    required this.userCurHealth,
    required this.userMaxHealth,
    required this.userStrength,
    required this.userSpeed,
    required this.botCurHealth,
    required this.botMaxHealth,
    required this.botStrength,
    required this.botSpeed,
    required this.turn,
    required this.log,
  });

  ///[fromJson] Creates [Battle] object by maping data from a Battles document [json] to appropriate variables
  static Battle fromJson(Map<String, dynamic> json) => Battle(
      userCurHealth: json['userCurHealth'],
      userMaxHealth: json['userMaxHealth'],
      userStrength: json['userStrength'],
      userSpeed: json['userSpeed'],
      botCurHealth: json['botCurHealth'],
      botMaxHealth: json['botMaxHealth'],
      botStrength: json['botStrength'],
      botSpeed: json['botSpeed'],
      turn: json['turn'],
      log: json['log']);
}

///[initBattle] Creates a battle by initializing data of a Battles documents based on the [userStats]
void initBattle(BattleCharacter userStats, userId) {
  Bot botStats = Bot(userStats.health, userStats.strength, userStats.speed);
  FirebaseFirestore.instance.collection('Battles').doc(userId).set({
    'userCurHealth': userStats.health,
    'userMaxHealth': userStats.health,
    'userStrength': userStats.strength,
    'userSpeed': userStats.speed,
    'botCurHealth': botStats.health,
    'botMaxHealth': botStats.health,
    'botStrength': botStats.strength,
    'botSpeed': botStats.speed,
    'turn': 0,
    'log': "",
  });
}

///[Workout] Object used to map data from 'workout information' database
class Workout {
  final String type;
  final int reps;
  final int sets;
  final int weight;

  Workout(
      {required this.type,
      required this.reps,
      required this.sets,
      required this.weight});

  ///[fromJson] Creates [Workout] object by maping data from a 'workout information' document [json] to appropriate variables
  static Workout fromJson(Map<String, dynamic> json) => Workout(
      type: json['body part'],
      reps: json['reps'],
      sets: json['sets'],
      weight: json['weight']);
}

///For reading in a user's xp points from the 'points' collection
class Points {
  final int points;

  Points({
    required this.points,
  });

  static Points fromJson(Map<String, dynamic> json) => Points(
        points: json['points'],
      );
}

///[readWorkouts] Creates a Stream object by maping data from documents of the 'workout information' collection to a list of Workout objects
Stream<List<Workout>> readWorkouts(userId) => FirebaseFirestore.instance
    .collection('workout information')
    .where('user', isEqualTo: userId)
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Workout.fromJson(doc.data())).toList());

///[readBattle] Creates a Stream object by maping data from a Battles document to a Battle Object
Stream<Battle> readBattle(userId) => FirebaseFirestore.instance
    .collection('Battles')
    .doc(userId)
    .snapshots()
    .map((DocumentSnapshot<Map<String, dynamic>> snapshot) =>
        Battle.fromJson(snapshot.data()!));

///Returns a list of workouts documents with user fields that match the [userId] (Used for [updateUserStats])
Future<List<Workout>> readWorkoutsInstance(userId) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('workout information')
      .where('user', isEqualTo: userId)
      .get();
  List<Workout> workoutList = [];
  querySnapshot.docs.forEach((doc) {
    workoutList.add(Workout.fromJson(doc.data() as Map<String, dynamic>));
  });
  return workoutList;
}

///Returns an int that represents the number of xp points stored in the 'points' docment with its id matching [userId])
///(Used for [updatePointsInc] & [updatePointsDec])
///Handles case of if user does not have an points doc
Future<int> readPointsInstance(userId) async {
  int pointsNum = 0;
  await FirebaseFirestore.instance
      .collection('points')
      .doc(authUser!.uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      pointsNum = documentSnapshot['points'];
    } else {
      FirebaseFirestore.instance.collection('points').doc(userId).set({
        'points': 0,
      });
    }
  });
  return pointsNum;
}

///Increases the points of a user (points doc recieved from [readPointsInstance]) based on the stats of the bot
void updatePointsInc(userId, botHealth, botStrength, botSpeed) async {
  int points = await readPointsInstance(userId);
  int xpGain = (botHealth * 0.02 + botStrength * 0.05 + botSpeed * 0.1).round();
  final pointsDoc = FirebaseFirestore.instance.collection('points').doc(userId);
  pointsDoc.update({'points': points + xpGain});
}

///Decreases the points of a user (points doc recieved from [readPointsInstance]) based on the stats of the bot
///(user will lose half of the xp that the user would have gained in [updatePointsInc])
void updatePointsDec(userId, botHealth, botStrength, botSpeed) async {
  int points = await readPointsInstance(userId);
  int xpLose =
      ((botHealth * 0.02 + botStrength * 0.05 + botSpeed * 0.1) * 0.5).round();
  if (points - xpLose < 0) {
    await FirebaseFirestore.instance.collection('points').doc(userId).set({
      'points': 0,
    });
  } else {
    FirebaseFirestore.instance
        .collection('points')
        .doc(userId)
        .update({'points': points - xpLose});
  }
}

void updateCurHealth(docId, userHealth, botHealth) {
  final battleDoc = FirebaseFirestore.instance.collection('Battles').doc(docId);
  battleDoc.update({
    'userCurHealth': userHealth,
    'botCurHealth': botHealth,
  });
}

///Updates stats of a user while they have an ongoing battle (called when battlescreen page is loaded)
void updateUserStats(Battle curBattle, userId) async {
  List<Workout> workoutList = await readWorkoutsInstance(userId);
  BattleCharacter userStats = calcStats(workoutList);
  int healthDif = userStats.health - curBattle.userMaxHealth;
  final battleDoc =
      FirebaseFirestore.instance.collection('Battles').doc(userId);
  await battleDoc.update({
    'userCurHealth': curBattle.userCurHealth + healthDif,
    'userMaxHealth': userStats.health,
    'userStrength': userStats.strength,
    'userSpeed': userStats.speed,
  });
}

///[updateTurn] Updates the turn field of a Battles document with the id matching [docId]
void updateTurn(docId, turn) {
  final battleDoc = FirebaseFirestore.instance.collection('Battles').doc(docId);
  battleDoc.update({
    'turn': turn,
  });
}

void updateLog(docId, turnMsg) {
  final battleDoc = FirebaseFirestore.instance.collection('Battles').doc(docId);
  battleDoc.update({
    'log': turnMsg,
  });
}

///[deleteDoc] Deletes a document from the Battles collection that posses the id [docId]
void deleteDoc(docId) {
  final battleDoc = FirebaseFirestore.instance.collection('Battles').doc(docId);
  battleDoc.delete();
}

final authUser = FirebaseAuth.instance.currentUser;

Future<void> deleteCurrentDoc() async {
  //does same thing as deleteDoc but for current workouts
  //used to remove current workouts once user hits the battle button.
  // gives a clean slate to pull points from after each "workout session"
  final Query<Map<String, dynamic>> currentWork = FirebaseFirestore.instance
      .collection('current workouts')
      .where('user', isEqualTo: authUser!.uid);
  final QuerySnapshot query = await currentWork
      .get(); //gets all the documents from the user.uid specific collection

  for (DocumentSnapshot documentSnapshot in query.docs) {
    await documentSnapshot.reference.delete();
  }
}

///[calcStats] Calculates the health, strength, and speed of a user based on a list of [Workout] objects
BattleCharacter calcStats(List<Workout> workoutList) {
  BattleCharacter temp = BattleCharacter(0, 0, 0);
  int backWeight = 0;
  int backReps = 0;
  int backSets = 0;
  int chestWeight = 0;
  int chestReps = 0;
  int chestSets = 0;
  int armsWeight = 0;
  int armsReps = 0;
  int armsSets = 0;
  int legsWeight = 0;
  int legsReps = 0;
  int legsSets = 0;
  workoutList.forEach((workout) {
    if (workout.type == 'Back') {
      backWeight += workout.weight;
      backReps += workout.reps;
      backSets += workout.sets;
    }
    if (workout.type == 'Chest') {
      chestWeight += workout.weight;
      chestReps += workout.reps;
      chestSets += workout.sets;
    }
    if (workout.type == 'Arms') {
      armsWeight += workout.weight;
      armsReps += workout.reps;
      armsSets += workout.sets;
    }
    if (workout.type == 'Legs') {
      legsWeight += workout.weight;
      legsReps += workout.reps;
      legsSets += workout.sets;
    }
  });
  temp.health = (((backWeight / 2) * backReps * backSets) / 2000 +
          ((chestWeight / 2) * chestReps * chestSets) / 6000 +
          ((legsWeight / 2) * legsReps * legsSets) / 10000)
      .round();
  temp.strength = (((armsWeight / 2) * armsReps * armsSets) / 2000 +
          ((chestWeight / 2) * chestReps * chestSets) / 6000)
      .round();
  temp.speed = ((90 * ((legsWeight / 2) * legsReps * legsSets)) /
          (((legsWeight / 2) * legsReps * legsSets) + 300000))
      .round(); //horizontal asymptote at 90

  return temp;
}

class UserStatsScreen extends StatefulWidget {
  const UserStatsScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _UserStatsScreen createState() => _UserStatsScreen();
}

class _UserStatsScreen extends State<UserStatsScreen> {
  final authUser = FirebaseAuth.instance
      .currentUser; //authUser!.uid in builder (and function args) and userId for method params

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
                child: Text("User Info"),
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
                      context); //To close the drawer when moving to the next page
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
                stream: readWorkouts(authUser!.uid),
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => BattleLogListScreen()));
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 40),
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text("Battle Log"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (authUser != null) {
                              FirebaseFirestore.instance
                                  .collection('Battles')
                                  .doc(authUser!.uid)
                                  .get()
                                  .then((DocumentSnapshot documentSnapshot) {
                                if (documentSnapshot.exists) {
                                  Battle curBattle = Battle.fromJson(
                                      documentSnapshot.data()
                                          as Map<String, dynamic>);
                                  updateUserStats(curBattle, authUser!.uid);
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => BattleScreen()));
                                } else if ((userHealth == 0) |
                                    (userStrength == 0)) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Wait!'),
                                      content: const Text(
                                          "You must complete more workouts before you can begin a battle\n(Your Health and Strength must be above 0)"),
                                      actions: [
                                        TextButton(
                                            child: const Text('OK'),
                                            onPressed: () =>
                                                Navigator.pop(context)),
                                      ],
                                    ),
                                  );
                                } else {
                                  initBattle(userStats, authUser!.uid);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BattleScreen()));
                                  deleteCurrentDoc();
                                }
                              });
                            } else {
                              throw ArgumentError("User is not signed in!");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 40),
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text("Battle"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const WorkoutPage()));
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 40),
                            backgroundColor: Colors.purple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text("Home page"),
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

class BattleScreen extends StatefulWidget {
  const BattleScreen({super.key});
  @override
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  String _turnButtonText = "Next Turn";
  String _logText = "";
  var _logColor = Colors.green;
  int _counter = 15; //milliseconds
  Timer? _timer;
  bool _isButtonActive = true;

//
  void _startTimer() {
    setState(() => _isButtonActive = false);
    _counter = 15;
    _timer = Timer.periodic(Duration(milliseconds: 50), (_) {
      if (_counter > 0) {
        //setState(() {
        _counter--;
        //});
      } else {
        setState(() {
          _isButtonActive = true;
          _timer!.cancel();
        });
      }
    });
  }

  void action(Battle curBattle, String log) {
    var rand = new Random();
    if ((curBattle.userCurHealth <= 0) || curBattle.userCurHealth <= 0) {}
    if (curBattle.turn % 2 == 0) {
      if (rand.nextInt(100) < curBattle.botSpeed) {
        setState(() {
          _logColor = Colors.green;
          _logText = "User misses enemy";
          log = "${log}/m/${_logText}";
        });
      } else {
        curBattle.botCurHealth -= curBattle.userStrength;
        setState(() {
          _logColor = Colors.green;
          _logText = "User hits enemy for ${curBattle.userStrength} damage";
          log = "${log}/h${curBattle.userStrength}/${_logText}";
        });
      }
    } else {
      if (rand.nextInt(100) < curBattle.userSpeed) {
        setState(() {
          _logColor = Colors.red;
          _logText = "Enemy misses user";
          log = "${log}/m/${_logText}";
        });
      } else {
        curBattle.userCurHealth -= curBattle.botStrength;
        setState(() {
          _logColor = Colors.red;
          _logText = "Enemy hits user for ${curBattle.botStrength} damage";
          log = "${log}/h${curBattle.botStrength}/${_logText}";
        });
      }
    }
    if (curBattle.botCurHealth <= 0) {
      setState(() {
        _turnButtonText = "The User Has Won!!!";
      });
    } else if (curBattle.userCurHealth <= 0) {
      setState(() {
        _turnButtonText = "The User Has Lost :(";
      });
    }
    updateLog(authUser!.uid, log);
    updateCurHealth(
        authUser!.uid, curBattle.userCurHealth, curBattle.botCurHealth);
    curBattle.turn++;
    updateTurn(authUser!.uid, curBattle.turn);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Battle'),
          backgroundColor: Colors.purple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: StreamBuilder<Battle>(
              stream: readBattle(authUser!.uid),
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
                  String log = curBattle.log;
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
                                onPressed: _isButtonActive
                                    ? () {
                                        _startTimer();
                                        if (curBattle.botCurHealth <= 0) {
                                          initBattleLog(
                                              curBattle, 1, authUser!.uid);
                                          updatePointsInc(
                                              authUser!.uid,
                                              curBattle.botMaxHealth,
                                              curBattle.botStrength,
                                              curBattle.botSpeed);
                                          Navigator.pop(context);
                                          deleteDoc(authUser!.uid);
                                        } else if (curBattle.userCurHealth <=
                                            0) {
                                          initBattleLog(
                                              curBattle, 0, authUser!.uid);
                                          updatePointsDec(
                                              authUser!.uid,
                                              curBattle.botMaxHealth,
                                              curBattle.botStrength,
                                              curBattle.botSpeed);
                                          Navigator.pop(context);
                                          deleteDoc(authUser!.uid);
                                        } else {
                                          action(curBattle, log);
                                        }
                                      }
                                    : null,
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
