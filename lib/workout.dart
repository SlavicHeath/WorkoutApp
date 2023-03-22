import 'package:flutter/material.dart';

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

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String buttonName = 'Arms';

  String butt2Name = 'Legs';

  String butt3Name = 'Back';

  String butt4Name = 'Chest';

  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WorkoutPage(),
    );
  }
}

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  String buttonName = 'Arms';

  String butt2Name = 'Legs';

  String butt3Name = 'Back';

  String butt4Name = 'Chest';

  int currentIndex = 1;

  final ButtonStyle workoutButton = ElevatedButton.styleFrom(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
      shape: const StadiumBorder(),
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('SELECT MUSCLE GROUP')),
        backgroundColor: Colors.purple,
      ),
      body: Center(
          child: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: workoutButton,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const ArmPage();
                        },
                      ),
                    );
                  },
                  child: Text(buttonName,
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: workoutButton,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const LegPage();
                        },
                      ),
                    );
                  },
                  child: Text(butt2Name,
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: workoutButton,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const BackPage();
                        },
                      ),
                    );
                  },
                  child: Text(butt3Name,
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              width: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: workoutButton,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return const ChestPage();
                        },
                      ),
                    );
                  },
                  child: Text(butt4Name,
                      style: const TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}

class ArmPage extends StatefulWidget {
  const ArmPage({super.key});

  @override
  State<ArmPage> createState() => _ArmPageState();
}

class _ArmPageState extends State<ArmPage> {
  String armName1 = 'Biceps';
  String armName2 = 'Triceps';
  String armName3 = 'Shoulders';

  final ButtonStyle workoutButton = ElevatedButton.styleFrom(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
      shape: const StadiumBorder(),
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

  Future openDialog() => showDialog(
        //pop up dialog for when user presses one of the specific muscle buttons
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Enter workout information'),
            content: Column(children: [
              // creates a list of textfields
              TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Name*')),
              TextFormField(
                  //optional textfield to enter name of workout (if user wants to keep track of such information)
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Weight (lbs)')),
              TextFormField(
                  //enter the weight
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Sets')),
              TextFormField(
                  //enter amount of reps
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Reps'))
            ]),
            actions: [
              TextButton(
                child: const Text(
                    'CANCEL'), //User presses this button to cancel/back out if they desire
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                    //User presses this button to submit valid information
                    'SUBMIT'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(); //action that allows user to return to specific muscle group screen
                },
              )
            ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('ARMS')),
          backgroundColor: Colors.purple,
        ),
        body: Center(
            child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 75,
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: workoutButton,
                    onPressed: () {
                      openDialog();
                    },
                    child: Center(child: Text(armName1)),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: workoutButton,
                    onPressed: () {
                      openDialog();
                    },
                    child: Center(child: Text(armName2)),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: workoutButton,
                    onPressed: () {
                      openDialog();
                    },
                    child: Center(child: Text(armName3)),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}

class LegPage extends StatefulWidget {
  const LegPage({super.key});

  @override
  State<LegPage> createState() => _LegPageState();
}

class _LegPageState extends State<LegPage> {
  String legName1 = 'Quads';
  String legName2 = 'Glutes/Hamstring';
  String legName3 = 'Calves';

  final ButtonStyle workoutButton = ElevatedButton.styleFrom(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
      shape: const StadiumBorder(),
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

  Future openDialog() => showDialog(
        //pop up dialog for when user presses one of the specific muscle buttons
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Enter workout information'),
            content: Column(children: [
              // creates a list of textfields
              TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Name*')),
              TextFormField(
                  //optional textfield to enter name of workout (if user wants to keep track of such information)
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Weight (lbs)')),
              TextFormField(
                  //enter the weight
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Sets')),
              TextFormField(
                  //enter amount of reps
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Reps'))
            ]),
            actions: [
              TextButton(
                child: const Text(
                    'CANCEL'), //User presses this button to cancel/back out if they desire
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                    //User presses this button to submit valid information
                    'SUBMIT'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(); //action that allows user to return to specific muscle group screen
                },
              )
            ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('LEGS')),
          backgroundColor: Colors.purple,
        ),
        body: Center(
            child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 75,
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: workoutButton,
                    onPressed: () {
                      openDialog();
                    },
                    child: Center(child: Text(legName1)),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ElevatedButton(
                    style: workoutButton,
                    onPressed: () {
                      openDialog();
                    },
                    child: Center(child: Text(legName2)),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: workoutButton,
                    onPressed: () {
                      openDialog();
                    },
                    child: Center(child: Text(legName3)),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}

class BackPage extends StatefulWidget {
  const BackPage({super.key});

  @override
  State<BackPage> createState() => _BackPageState();
}

class _BackPageState extends State<BackPage> {
  String backName1 = 'Upper Back';
  String backName2 = 'Middle Back';
  String backName3 = 'Lower Back';

  final ButtonStyle workoutButton = ElevatedButton.styleFrom(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
      shape: const StadiumBorder(),
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

  Future openDialog() => showDialog(
        //pop up dialog for when user presses one of the specific muscle buttons
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Enter workout information'),
            content: Column(children: [
              // creates a list of textfields
              TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Name*')),
              TextFormField(
                  //optional textfield to enter name of workout (if user wants to keep track of such information)
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Weight (lbs)')),
              TextFormField(
                  //enter the weight
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Sets')),
              TextFormField(
                  //enter amount of reps
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Reps'))
            ]),
            actions: [
              TextButton(
                child: const Text(
                    'CANCEL'), //User presses this button to cancel/back out if they desire
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                    //User presses this button to submit valid information
                    'SUBMIT'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(); //action that allows user to return to specific muscle group screen
                },
              )
            ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('BACK')),
        ),
        body: Center(
            child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 75,
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: workoutButton,
                    onPressed: () {
                      openDialog();
                    },
                    child: Center(child: Text(backName1)),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: workoutButton,
                    onPressed: () {
                      openDialog();
                    },
                    child: Center(child: Text(backName2)),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: workoutButton,
                    onPressed: () {
                      openDialog();
                    },
                    child: Center(child: Text(backName3)),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}

class ChestPage extends StatefulWidget {
  const ChestPage({super.key});

  @override
  State<ChestPage> createState() => _ChestPageState();
}

class _ChestPageState extends State<ChestPage> {
  String chestName1 = 'Upper Chest';
  String chestName2 = 'Middle Chest';
  String chestName3 = 'Lower Chest';

  final ButtonStyle workoutButton = ElevatedButton.styleFrom(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
      shape: const StadiumBorder(),
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

  Future openDialog() => showDialog(
        //pop up dialog for when user presses one of the specific muscle buttons
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Enter workout information'),
            content: Column(children: [
              // creates a list of textfields
              TextFormField(
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Name*')),
              TextFormField(
                  //optional textfield to enter name of workout (if user wants to keep track of such information)
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Weight (lbs)')),
              TextFormField(
                  //enter the weight
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Sets')),
              TextFormField(
                  //enter amount of reps
                  autofocus: true,
                  decoration: const InputDecoration(hintText: 'Reps'))
            ]),
            actions: [
              TextButton(
                child: const Text(
                    'CANCEL'), //User presses this button to cancel/back out if they desire
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                    //User presses this button to submit valid information
                    'SUBMIT'),
                onPressed: () {
                  Navigator.of(context)
                      .pop(); //action that allows user to return to specific muscle group screen
                },
              )
            ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('CHEST')),
        ),
        body: Center(
            child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 75,
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: workoutButton,
                    onPressed: () {
                      openDialog();
                    },
                    child: Center(child: Text(chestName1)),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: workoutButton,
                    onPressed: () {
                      openDialog();
                    },
                    child: Center(child: Text(chestName2)),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: workoutButton,
                    onPressed: () {
                      openDialog();
                    },
                    child: Center(child: Text(chestName3)),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
