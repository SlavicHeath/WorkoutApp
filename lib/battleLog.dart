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

Widget buildLog(BattleLog battleLog) =>
    ListTile(title: Text(battleLog.getDate()));

Stream<List<BattleLog>> readBattleLog(userId) => FirebaseFirestore.instance
    .collection('BattleLogs')
    .where('user', isEqualTo: userId)
    .orderBy('date')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => BattleLog.fromJson(doc.data())).toList());

class BattleLogScreen extends StatefulWidget {
  const BattleLogScreen({super.key});
  @override
  _BattleLogScreenState createState() => _BattleLogScreenState();
}

class _BattleLogScreenState extends State<BattleLogScreen> {
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
                    return ListView(
                      children: battleLogs.map(buildLog).toList(),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })));
  }
}
