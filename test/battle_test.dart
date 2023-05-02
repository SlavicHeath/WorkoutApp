//Ben Williams

import 'package:flutter_test/flutter_test.dart';
import 'package:workoutpet/battle.dart';
import 'package:workoutpet/battleLog.dart';
//import 'package:workoutpet/battleLog.dart';
import "dart:math";
import 'package:flutter/material.dart';

//Augmented version of the action function in the battle screen
String _logText = "";
String _turnButtonText = "";
void action(Battle curBattle, String log) {
  var rand = new Random();
  if ((curBattle.userCurHealth <= 0) || curBattle.userCurHealth <= 0) {}
  if (curBattle.turn % 2 == 0) {
    if (rand.nextInt(100) < curBattle.botSpeed) {
      //setState(() {
      //_logColor = Colors.green;
      _logText = "User misses enemy";
      log = "${log}/m/${_logText}";
      //});
    } else {
      curBattle.botCurHealth -= curBattle.userStrength;
      //setState(() {
      //_logColor = Colors.green;
      _logText = "User hits enemy for ${curBattle.userStrength} damage";
      log = "${log}/h${curBattle.userStrength}/${_logText}";
      //});
    }
  } else {
    if (rand.nextInt(100) < curBattle.userSpeed) {
      //setState(() {
      //_logColor = Colors.red;
      _logText = "Enemy misses user";
      log = "${log}/m/${_logText}";
      //});
    } else {
      curBattle.userCurHealth -= curBattle.botStrength;
      //setState(() {
      //_logColor = Colors.red;
      _logText = "Enemy hits user for ${curBattle.botStrength} damage";
      log = "${log}/h${curBattle.botStrength}/${_logText}";
      //});
    }
  }
  if (curBattle.botCurHealth <= 0) {
    //setState(() {
    _turnButtonText = "The User Has Won!!!";
    //});
  } else if (curBattle.userCurHealth <= 0) {
    //setState(() {
    _turnButtonText = "The User Has Lost :(";
    //});
  }
  //updateLog(authUser!.uid, log);
  //updateCurHealth(
  //    authUser!.uid, curBattle.userCurHealth, curBattle.botCurHealth);
  //curBattle.turn++;
  //updateTurn(authUser!.uid, curBattle.turn);
}

int userCurHealth = 100;
int botCurHealth = 100;
Color _logColor = Colors.grey;
//Augmented version of the action function in the battle screen
//actual function only contains one parameter (log), however in orde to test this function userCurHealth, botCurHealth, index, and turn have been added
void replay(String log, int index, int turn) {
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
    //setState(() {
    _logColor = Colors.green;
    //});
  } else {
    //setState(() {
    _logColor = Colors.red;
    //});
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
      //setState(() {
      botCurHealth -= int.parse(dmg);
      //});
    } else {
      //setState(() {
      userCurHealth -= int.parse(dmg);
      //});
    }
    //end of battle
    if ((userCurHealth <= 0) | (botCurHealth <= 0)) {
      //setState(() {
      _turnButtonText = "End of Battle";
      //});
    }
  }
  //setState(() {
  turn += 1;
  //});
  botCurHealth = 50;
}

void main() {
  test("Testing action: user hit", () {
    Battle testBattle = Battle(
        userCurHealth: 100,
        userMaxHealth: 100,
        userStrength: 50,
        userSpeed: 0,
        botCurHealth: 100,
        botMaxHealth: 100,
        botStrength: 50,
        botSpeed: 0,
        turn: 0,
        log: "");
    action(testBattle, testBattle.log);
    expect(testBattle.botCurHealth,
        testBattle.botMaxHealth - testBattle.userStrength);
  });

  test("Testing action: enemy hit", () {
    Battle testBattle = Battle(
        userCurHealth: 100,
        userMaxHealth: 100,
        userStrength: 50,
        userSpeed: 0,
        botCurHealth: 100,
        botMaxHealth: 100,
        botStrength: 50,
        botSpeed: 0,
        turn: 1,
        log: "");
    action(testBattle, testBattle.log);
    expect(testBattle.userCurHealth,
        testBattle.userMaxHealth - testBattle.botStrength);
  });

  test("Testing action: user miss", () {
    Battle testBattle = Battle(
        userCurHealth: 100,
        userMaxHealth: 100,
        userStrength: 50,
        userSpeed: 0,
        botCurHealth: 100,
        botMaxHealth: 100,
        botStrength: 50,
        botSpeed: 100, //user will always miss at 100 speed
        turn: 0,
        log: "");
    action(testBattle, testBattle.log);
    expect(testBattle.botCurHealth, testBattle.botMaxHealth);
  });

  test("Testing action: enemy miss", () {
    Battle testBattle = Battle(
        userCurHealth: 100,
        userMaxHealth: 100,
        userStrength: 50,
        userSpeed: 100,
        botCurHealth: 100,
        botMaxHealth: 100,
        botStrength: 50,
        botSpeed: 0,
        turn: 1,
        log: "");
    action(testBattle, testBattle.log);
    expect(testBattle.userCurHealth, testBattle.userMaxHealth);
  });

  test("Testing action: user victory", () {
    Battle testBattle = Battle(
        userCurHealth: 100,
        userMaxHealth: 100,
        userStrength: 50,
        userSpeed: 0,
        botCurHealth: 0,
        botMaxHealth: 100,
        botStrength: 50,
        botSpeed: 0,
        turn: 0,
        log: "");
    action(testBattle, testBattle.log);
    expect(_turnButtonText, "The User Has Won!!!");
  });

  test("Testing action: bot victory", () {
    Battle testBattle = Battle(
        userCurHealth: 0,
        userMaxHealth: 100,
        userStrength: 50,
        userSpeed: 0,
        botCurHealth: 100,
        botMaxHealth: 100,
        botStrength: 50,
        botSpeed: 0,
        turn: 1,
        log: "");
    action(testBattle, testBattle.log);
    expect(_turnButtonText, "The User Has Lost :(");
  });

  test("Testing replay: read first action", () {
    _logText = "";
    userCurHealth = 100;
    botCurHealth = 100;
    String log =
        "/m/User misses enemy/m/Enemy misses user/h50/User hits enemy for 50 damage/h50/Enemy hits user for 50 damage";
    replay(log, 1, 0);
    expect(_logText, "User misses enemy");
  });

  test("Testing replay: read second action", () {
    _logText = "";
    userCurHealth = 100;
    botCurHealth = 100;
    String log =
        "/m/User misses enemy/m/Enemy misses user/h50/User hits enemy for 50 damage/h50/Enemy hits user for 50 damage";
    replay(log, 21, 1);
    expect(_logText, "Enemy misses user");
  });

  test("Testing replay: user turn log color", () {
    _logText = "";
    userCurHealth = 100;
    botCurHealth = 100;
    String log =
        "/m/User misses enemy/m/Enemy misses user/h50/User hits enemy for 50 damage/h50/Enemy hits user for 50 damage";
    replay(log, 1, 0);
    expect(_logColor, Colors.green);
  });

  test("Testing replay: enemy turn log color", () {
    _logText = "";
    userCurHealth = 100;
    botCurHealth = 100;
    String log =
        "/m/User misses enemy/m/Enemy misses user/h50/User hits enemy for 50 damage/h50/Enemy hits user for 50 damage";
    replay(log, 21, 1);
    expect(_logColor, Colors.red);
  });

  test("Testing replay: user hit", () {
    _logText = "";
    userCurHealth = 100;
    botCurHealth = 100;
    String log =
        "/h50/User hits enemy for 50 damage/h50/Enemy hits user for 50 damage";
    replay(log, 1, 0);
    expect(botCurHealth, 50);
  });

  test("Testing replay: enemy hit", () {
    _logText = "";
    userCurHealth = 100;
    botCurHealth = 100;
    String log =
        "/h50/User hits enemy for 50 damage/h50/Enemy hits user for 50 damage";
    replay(log, 35, 1);
    expect(userCurHealth, 50);
  });
}
