// Ryan Lehner
// set up a character class
import 'package:flutter/widgets.dart';

class Character {
  // each one has to be it's own image so the pet can grow individually
  Image head;
  Image leg;
  Image body;
  Image arm;
  Image accessories;

  // contructor
  Character(this.head, this.leg, this.body, this.arm, this.accessories);
}
