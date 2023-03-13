//Ben Williams

//Placeholder until character class is fully complete
//(will pass in a character object and use .get()s to calculate health, strenth , etc...)
class Battle {
  int? UserHealth;
  int? UserStrength;
  int? BotHealth;
  int? BotStrength;

  //contructor
  Battle(this.UserHealth, this.UserStrength, this.BotHealth, this.BotStrength);
}

var battle = [
  //complete constructor
  Battle(2000, 100, 1500, 125),
  //User data missing
  Battle(0, 0, 1000, 200),
  //Bot data missing
  Battle(5000, 35, 0, 0),
  //All data missing
  Battle(0, 0, 0, 0)
];
