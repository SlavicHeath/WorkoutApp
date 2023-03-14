//Ben Williams

import 'character.dart';
import 'dart:math';

class Bot {
  //Health and strength are being stored here until they are incorporated
  //into the character class
  int botHealth = 0;
  int botStrength = 0;
  var botCharacter;

  //Constructor passes in a user's health and strength in order to create an
  //opponent that possesses similar stats to the user and has character
  //images correlating to the degree of the oppoenent's stats
  Bot(int healthTemplate, int strengthTemplate) {
    var rand = new Random();
    double randMultiplier = rand.nextInt(21) * .01; //randMultiplier = 0 to .2

    //For each stat (health & strength) each stat is either (50/50 chance) multiplied by
    //randMultiplier + 1 or multiplied by 1 - randmultiplier so that each stat
    //varries only by 20% of the user's respective stat
    //Health:
    if (rand.nextInt(2) > 0) {
      botHealth = ((randMultiplier + 1) * healthTemplate) as int;
    } else {
      botHealth = ((1 - randMultiplier) * healthTemplate) as int;
    }
    //Strength:
    if (rand.nextInt(2) > 0) {
      botStrength = ((randMultiplier + 1) * strengthTemplate) as int;
    } else {
      botStrength = ((1 - randMultiplier) * strengthTemplate) as int;
    }

    //opponent will have images based on their strength once images are created
    //and character class incorporates stats

    //botCharacter = character(head, leg, body, arm, accessories);
  }
}
