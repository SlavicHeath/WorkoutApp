//Ben Williams

import 'character.dart';
import 'bot.dart';
import 'package:flutter/material.dart';

///
/// [Battle.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@global]
///
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
    botCharacter = Bot(userCharacter.health, userCharacter.strength);
    botCurHealth = botCharacter.health;
  }
}

///
/// [BattleInitScreen.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		StatefulWidget]
/// [@global]
///
class BattleInitScreen extends StatefulWidget {
  const BattleInitScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _BattleInitScreenState createState() => _BattleInitScreenState();
}

///
/// [_BattleInitScreenState.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		State]
/// [@global]
///
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
}

///
/// [MainBattleScreen.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		StatefulWidget]
/// [@global]
///
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

///
/// [_MainBattleScreenState.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		State]
/// [@global]
///
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
            ],
          ),
        ));
  }
}
/* battle examples do not work until character incorporates stats (health, strength, etc...)
var battle = [
  //complete constructor
  Battle(2000, 100, 1500, 125),
  //User data missing
  Battle(0, 0, 1000, 200),
  //Bot data missing
  Battle(5000, 35, 0, 0),
  //All data missing
  Battle(0, 0, 0, 0)
];*/