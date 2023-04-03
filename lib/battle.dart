//Ben Williams

import 'character.dart';
import 'bot.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

//Placeholder until character class is fully complete
//(will pass in a character object and use .get()s to calculate health, strenth , etc...)
class Battle {
  //var userCharacter;
  var userCharacter;
  var botCharacter;
  int userCurHealth = 0;
  int botCurHealth = 0;

  //contructor
  Battle(this.userCharacter) {
    userCurHealth = userCharacter.health;
    //generates an opponent for the battle based on the user's stats
    botCharacter =
        Bot(userCharacter.health, userCharacter.strength, userCharacter.speed);
    botCurHealth = botCharacter.health;
  }
}

void initBattle(BattleCharacter userStats) {
  Bot botStats = Bot(userStats.health, userStats.strength, userStats.speed);
  FirebaseFirestore.instance.collection('Battles').add({
    'userCurHealth': userStats.health,
    'userStrength': userStats.strength,
    'userSpeed': userStats.speed,
    'botCurHealth': botStats.health,
    'botStrength': botStats.strength,
    'botSpeed': botStats.speed,
    'Turn': 0,
  });
}

class Workout {
  final int reps;
  final int sets;
  final int weight;

  Workout({required this.reps, required this.sets, required this.weight});

  static Workout fromJson(Map<String, dynamic> json) =>
      Workout(reps: json['reps'], sets: json['sets'], weight: json['weight']);
}

Stream<List<Workout>> readWorkouts() => FirebaseFirestore.instance
    .collection('workout information')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Workout.fromJson(doc.data())).toList());

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
  final Stream<QuerySnapshot> _userStats =
      FirebaseFirestore.instance.collection('workout information').snapshots();
  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('User\'s Battle Stats'),
          backgroundColor: Colors.purple,
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
                        /*ElevatedButton(
                onPressed: () {
                  initBattle(userStats);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BattlePreview()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 40),
                  backgroundColor: Colors.purple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text("Find Opponent"),
              ),*/
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

/*class BattleInitScreen extends StatefulWidget {
  const BattleInitScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _BattleInitScreenState createState() => _BattleInitScreenState();
}

class _BattleInitScreenState extends State<BattleInitScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _healthController = TextEditingController();

  TextEditingController _strengthController = TextEditingController();

  int _botHealth = 0;
  int _botStrength = 0;

  void _initBattle() {
    int health = int.tryParse(_healthController.text) ?? 0;
    int strength = int.tryParse(_strengthController.text) ?? 0;

    Battle newBattle = Battle(battleCharacter(health, strength));

    setState(() {
      _botHealth = newBattle.botCharacter.health;
      _botStrength = newBattle.botCharacter.health;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MainBattleScreen(
              battle: newBattle,
              botHealth: _botHealth,
              botStrength: _botStrength)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battle Input'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _healthController,
                decoration: const InputDecoration(
                  labelText: 'User\'s Health',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.parse(value) < 0) {
                    return 'Health value is invalid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _strengthController,
                decoration: const InputDecoration(
                  labelText: 'User\'s Strength',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.parse(value) < 0) {
                    return 'Strength value is invalid';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _initBattle();
                  }
                },
                child: Text('Start Battle'),
              ),
              SizedBox(height: 16.0),
              // ignore: prefer_const_constructors
            ],
          ),
        ),
      ),
    );
  }
} */
/*
class MainBattleScreen extends StatefulWidget {
  Battle battle;
  int botHealth, botStrength;
  MainBattleScreen(
      {super.key,
      required this.battle,
      required this.botHealth,
      required this.botStrength});
  @override
  _MainBattleScreenState createState() => _MainBattleScreenState(battle);
}

class _MainBattleScreenState extends State<MainBattleScreen> {
  Battle battle;
  _MainBattleScreenState(this.battle);

  @override
  Widget build(BuildContext context) {
    int userCurHealth = battle.userCurHealth;
    int botCurHealth = battle.botCurHealth;
    int userStrength = battle.userCharacter.strength;
    int botStrength = battle.botCharacter.strength;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Battle'),
          backgroundColor: Colors.purple,
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
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
            ],
          ),
        ));
  }
}*/
