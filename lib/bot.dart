//Ben Williams

import 'dart:math';

///
/// [BattleCharacter] Object that holds the stats of a user
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@global]
///
class BattleCharacter {
  int health = 0;
  int strength = 0;
  int speed = 0;

  BattleCharacter(this.health, this.strength, this.speed);
}

///
/// [Bot] Object that extends [BattleCharacter] and is used to generated random stats for a bot opponent
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		battleCharacter]
/// [@global]
///
class Bot extends BattleCharacter {
  //Health and strength are being stored here until they are incorporated
  //into the character class

  //Constructor passes in a user's health, strength, speed in order to create an
  //opponent that possesses similar stats to the user and has character
  //images correlating to the degree of the oppoenent's stats
  Bot(int healthTemplate, int strengthTemplate, int speedTemplate)
      : super(0, 0, 0) {
    var rand = new Random();
    double randMultiplier = rand.nextInt(21) * .01; //randMultiplier = 0 to .2
    health = ((0.95 + randMultiplier) * healthTemplate).round();
    randMultiplier = rand.nextInt(21) * .01;
    strength = ((0.95 + randMultiplier) * strengthTemplate).round();
    randMultiplier = rand.nextInt(21) * .01;
    speed = ((0.95 + randMultiplier) * speedTemplate).round();
  }
}
