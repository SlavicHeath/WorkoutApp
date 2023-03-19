//Ben Williams

import 'character.dart';
import 'bot.dart';
import 'package:flutter/material.dart';

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
    botCharacter = Bot(userCharacter.health, userCharacter.strength);
    botCurHealth = botCharacter.health;
  }
}

class BattleScreen extends StatefulWidget {
  const BattleScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
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
                  labelText: 'User Health',
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
                  labelText: 'Height (inch)',
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
              Text(
                'Opp Health = $_botHealth, ',
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
    );
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