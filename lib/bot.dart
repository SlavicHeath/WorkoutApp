//Ben Williams

import 'character.dart';
import 'dart:math';

class battleCharacter {
  int health = 0;
  int strength = 0;

  battleCharacter(this.health, this.strength);
}

class Bot extends battleCharacter {
  //Health and strength are being stored here until they are incorporated
  //into the character class

  //Constructor passes in a user's health and strength in order to create an
  //opponent that possesses similar stats to the user and has character
  //images correlating to the degree of the oppoenent's stats
  Bot(int healthTemplate, int strengthTemplate) : super(0, 0) {
    var rand = new Random();
    double randMultiplier = rand.nextInt(21) * .01; //randMultiplier = 0 to .2

    //For each stat (health & strength) each stat is either (50/50 chance) multiplied by
    //randMultiplier + 1 or multiplied by 1 - randmultiplier so that each stat
    //varries only by 20% of the user's respective stat
    //Health:
    if (rand.nextInt(2) > 0) {
      health = ((randMultiplier + 1) * healthTemplate).round();
    } else {
      health = ((1 - randMultiplier) * healthTemplate).round();
    }
    //Strength:
    if (rand.nextInt(2) > 0) {
      strength = ((randMultiplier + 1) * strengthTemplate).round();
    } else {
      strength = ((1 - randMultiplier) * strengthTemplate).round();
    }

    //opponent will have images based on their strength once images are created
    //and character class incorporates stats

    //botCharacter = character(head, leg, body, arm, accessories);
  }
}
