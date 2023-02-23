class Workout {
  /// A class representing muscle groups in addition to weight,
  /// intensity and number of times workout was done.

  String muscleGroup;
  num weight;
  String intensity;
  num sets;
  num reps;
  num workoutNum;

  ///ID for workouts done each day

  Workout(this.muscleGroup, this.weight, this.intensity, this.sets, this.reps,
      this.workoutNum);
}

// A sample list of workouts.
var SAMPLE_WORKOUTS = [
  Workout("legs", 225, "high", 3, 5, 1),
  Workout("arms", 35, "moderate", 4, 10, 1),
  Workout("back", 110, "easy", 4, 10, 1),

  ///Same sample but for the next day.
  Workout("chest", 185, "moderate", 3, 5, 2),
];
