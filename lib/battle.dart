//Ben Williams

import 'character.dart';
import 'bot.dart';

//Placeholder until character class is fully complete
//(will pass in a character object and use .get()s to calculate health, strenth , etc...)
class Battle {
  var userCharacter;
  var botCharacter;
  int userCurHealth = 0;
  int botCurHealth = 0;

  //contructor
  Battle(this.userCharacter) {
    userCurHealth = userCharacter.health;
    botCharacter = Bot(userCharacter.health, userCharacter.strength);
    botCurHealth = botCharacter.botHealth;
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
