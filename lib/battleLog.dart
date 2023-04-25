import 'package:workoutpet/main.dart';
import 'package:workoutpet/workout.dart';
import 'dart:math';
import 'bot.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workoutpet/battle.dart';

class BattleLog {
  String user;
  int userMaxHealth;
  int userStrength;
  int userSpeed;
  int botMaxHealth;
  int botStrength;
  int botSpeed;
  String log;
  Timestamp date;
  int win;

  BattleLog({
    required this.user,
    required this.userMaxHealth,
    required this.userStrength,
    required this.userSpeed,
    required this.botMaxHealth,
    required this.botStrength,
    required this.botSpeed,
    required this.log,
    required this.date,
    required this.win,
  });

  String getDate() {
    DateTime displayDate = date.toDate();
    var numberToMonthMap = {
      1: "Jan",
      2: "Feb",
      3: "Mar",
      4: "Apr",
      5: "May",
      6: "Jun",
      7: "Jul",
      8: "Aug",
      9: "Sep",
      10: "Oct",
      11: "Nov",
      12: "Dec",
    };
    return "${numberToMonthMap[displayDate.month]} ${displayDate.day} ${displayDate.year}";
  }

  static BattleLog fromJson(Map<String, dynamic> json) => BattleLog(
      user: json['user'],
      userMaxHealth: json['userMaxHealth'],
      userStrength: json['userStrength'],
      userSpeed: json['userSpeed'],
      botMaxHealth: json['botMaxHealth'],
      botStrength: json['botStrength'],
      botSpeed: json['botSpeed'],
      log: json['log'],
      date: json['date'],
      win: json['win']);

  String determineWinText() {
    if (win == 1) {
      return "W";
    } else {
      return "L";
    }
  }

  Color determineWinColor() {
    if (win == 1) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}

///Creates a document in the BattleLogs collection based on various stats from the current battle [curBattle] of a user with a uid matching [userId]
void initBattleLog(Battle curBattle, int win, userId) {
  FirebaseFirestore.instance.collection('BattleLogs').add({
    'user': userId,
    'userMaxHealth': curBattle.userMaxHealth,
    'userStrength': curBattle.userStrength,
    'userSpeed': curBattle.userSpeed,
    'botMaxHealth': curBattle.botMaxHealth,
    'botStrength': curBattle.botStrength,
    'botSpeed': curBattle.botSpeed,
    'log': curBattle.log,
    'date': FieldValue.serverTimestamp(),
    'win': win, // 1 denotes a win
  });
}

Widget buildLog(BattleLog battleLog, BuildContext context) => ListTile(
    title: Text(battleLog.getDate()),
    tileColor: Colors.purple,
    onTap: () => Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => BattleLogListScreen())),
    trailing: Container(
      child: Text("${battleLog.determineWinText()}",
          style: (TextStyle(color: battleLog.determineWinColor()))),
    ));

Stream<List<BattleLog>> readBattleLog(userId) => FirebaseFirestore.instance
    .collection('BattleLogs')
    .where('user', isEqualTo: userId)
    .orderBy('date', descending: true)
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => BattleLog.fromJson(doc.data())).toList());

class BattleLogListScreen extends StatefulWidget {
  const BattleLogListScreen({super.key});
  @override
  _BattleLogListScreenState createState() => _BattleLogListScreenState();
}

class _BattleLogListScreenState extends State<BattleLogListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Battle Log'),
          backgroundColor: Colors.purple,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StreamBuilder<List<BattleLog>>(
                stream: readBattleLog(authUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("Database Error: ${snapshot.error}");
                  } else if (snapshot.hasData) {
                    final battleLogs = snapshot.data!;
                    return ListView.separated(
                        itemCount: battleLogs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(battleLogs[index].getDate()),
                            tileColor: Colors.purple,
                            onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => BattleLogScreen(
                                        battleLog: battleLogs[index]))),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 10));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })));
  }
}

class BattleLogScreen extends StatefulWidget {
  final BattleLog battleLog;
  const BattleLogScreen({super.key, required this.battleLog});
  @override
  _BattleLogScreenState createState() => _BattleLogScreenState(battleLog);
}

class _BattleLogScreenState extends State<BattleLogScreen> {
  BattleLog battleLog;
  _BattleLogScreenState(this.battleLog);
  String _turnButtonText = "Replay Turn";
  String _logText = "";
  var _logColor = Colors.green;
  int index = 1; //skip first "/" in log
  int turn = 0;
  late int userCurHealth = widget.battleLog.userMaxHealth;
  late int userStrength = widget.battleLog.userStrength;
  late int userSpeed = widget.battleLog.userSpeed;
  late int botCurHealth = widget.battleLog.botMaxHealth;
  late int botStrength = widget.battleLog.botStrength;
  late int botSpeed = widget.battleLog.botSpeed;
  late String log = widget.battleLog.log;
  late String date = widget.battleLog.getDate();
  void replay(String log) {
    // a turn in log will look like /turnAction/_logText
    // turnAction[0] will = "h" (hit) or "m" (miss)
    //  any num after the initial char is the damage done on a hit, ie "h34" (where the strength of the hitter was 34)
    // _logText is what was displayed for the current turn in the log during the battle
    String turnAction = "";
    _logText = "";
    while (index < log.length) {
      if (log[index] != "/") {
        turnAction = "${turnAction}${log[index]}";
        index += 1;
      } else {
        break;
      }
    }
    index += 1;
    while (index < log.length) {
      if (log[index] != "/") {
        _logText = "${_logText}${log[index]}";
        index += 1;
      } else {
        break;
      }
    }
    index += 1;
    if (turn % 2 == 0) {
      setState(() {
        _logColor = Colors.green;
      });
    } else {
      setState(() {
        _logColor = Colors.red;
      });
    }
    //a successful hit
    if (turnAction[0] == "h") {
      int j = 1;
      String dmg = "";
      while (j < turnAction.length) {
        dmg = "${dmg}${turnAction[j]}";
        j += 1;
      }
      if (turn % 2 == 0) {
        setState(() {
          botCurHealth -= int.parse(dmg);
        });
      } else {
        setState(() {
          userCurHealth -= int.parse(dmg);
        });
      }
      //end of battle
      if ((userCurHealth <= 0) | (botCurHealth <= 0)) {
        setState(() {
          _turnButtonText = "End of Battle";
        });
      }
    }
    setState(() {
      turn += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${date} Battle Log'),
          backgroundColor: Colors.purple,
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
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
                            if ((userCurHealth <= 0) | (botCurHealth <= 0)) {
                              Navigator.pop(context);
                            } else {
                              replay(log);
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
            )));
  }
}
