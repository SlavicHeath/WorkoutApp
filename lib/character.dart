// Ryan Lehner
// set up a character class
import 'package:flutter/widgets.dart';
import 'package:workoutpet/character.dart';
import 'character.dart';

class Character {
  // each one has to be it's own image so the pet can grow individually
  Object head;
  Object leg;
  Object chest;
  Object back;
  Object arm;
  Object accessories;

  // constructor
  Character(
      this.head, this.leg, this.chest, this.back, this.arm, this.accessories);
}

class CharacterScale extends Character {
  // shows the base dimesensions of the character scale and location
  List<double> headSc = [0.85, 0.85, 0.85];
  List<double> headLo = [0, 0, 2];

  List<double> llArmSc = [0.28, 0.28, 0.9];
  List<double> llArmLo = [0, 2.5, -1.9];

  List<double> lrArmSc = [0.28, 0.28, 0.9];
  List<double> lrArmLo = [0, -2.5, -1.9];

  List<double> ulArmSc = [0.35, 1, 0.35];
  List<double> ulArmLo = [0, 1.9, -0.3];

  List<double> urArmSc = [0.35, 1, 0.35];
  List<double> urArmLo = [0, -1.9, -0.3];

  List<double> uTorsoSc = [0.8, 1.2, 1];
  List<double> uTorsoLo = [0, 0, 0];

  List<double> lTorsoSc = [0.8, 0.8, 1];
  List<double> lTorsoLo = [0, 0, -2];

  List<double> ulLegSc = [0.5, 0.5, 1.25];
  List<double> ulLegLo = [0, 0.9, -3.8];

  List<double> urLegSc = [0.5, 0.5, 1.25];
  List<double> urLegLo = [0, -0.9, -3.8];

  List<double> llLegSc = [0.4, 0.4, 1];
  List<double> llLegLo = [0, 1.35, -6];

  List<double> lrLegSc = [0.4, 0.4, 1];
  List<double> lrLegLo = [0, -1.35, -6];

  CharacterScale(super.head, super.leg, super.chest, super.back, super.arm,
      super.accessories);
}

class CharacterMult extends Character {
  // lets the size of the character's body grow for examples
  double legMult = 0.0;
  double chestMult = 0.0;
  double backMult = 0.0;
  double armMult = 0.0;

  CharacterMult(this.legMult, this.chestMult, this.backMult, this.armMult)
      : super(0.0, 0.0, 0.0, 0.0, 0.0, 0.0);
}
