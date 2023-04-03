import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
            mainAxisAlignment: MainAxisAlignment.end,
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
                            return PrevWorkPage();
                          },
                        ),
                      );
                    },
                    child: const Center(
                      child: Text('PAST WORKOUTS',
                          style: TextStyle(color: Colors.white)),
                    ),
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
      ),
    );
  }
}

class ArmPage extends WorkoutPage {
  const ArmPage({super.key});

  @override
  State<ArmPage> createState() => _ArmPageState();
}

class _ArmPageState extends State<ArmPage> {
  String armName1 = 'Biceps';
  String armName2 = 'Triceps';
  String armName3 = 'Shoulders';

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
                      openDialog(context);
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
                      openDialog(context);
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
                      openDialog(context);
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
                      openDialog(context);
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
                      openDialog(context);
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
                      openDialog(context);
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

  String? workoutName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('BACK')),
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
                      openDialog(context);
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
                      openDialog(context);
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
                      openDialog(context);
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

  CollectionReference workouts =
      FirebaseFirestore.instance.collection('workout information');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('CHEST')),
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
                      openDialog(context);
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
                      openDialog(context);
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
                      openDialog(context);
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

class PrevWorkPage extends StatefulWidget {
  PrevWorkPage({super.key});

  @override
  _PrevWorkPageState createState() => _PrevWorkPageState();
}

class _PrevWorkPageState extends State<PrevWorkPage> {
  final _formKey = GlobalKey<FormState>();
  final authUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PREVIOUS WORKOUTS'),
        backgroundColor: Colors.purple,
      ),
      body: FutureBuilder(
        future: _retrieveinfo(),
        //Calls into firebase to retrieve data from workout info document
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            // Will prompt user that there's no data therefore no previous workouts
            return const Center(
              child: Text('There are no previous workouts'),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              return Card(
                child: ListTile(
                  //displays previous workouts in a tile list format
                  autofocus: true,
                  leading: Text(document['name']),
                  title: Text(
                      '${document['sets']}'), // $ allows integer data to be read in
                  subtitle: Text('${document['reps']}'),
                  trailing: Text('${document['weight']}'),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

//Buttons for original workout page

String buttonName = 'Arms';

String butt2Name = 'Legs';

String butt3Name = 'Back';

String butt4Name = 'Chest';

int currentIndex = 1;

//Button layout for each button utilized in workout
final ButtonStyle workoutButton = ElevatedButton.styleFrom(
    backgroundColor: Colors.purple,
    foregroundColor: Colors.white,
    shape: const StadiumBorder(),
    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

final _formKey = GlobalKey<FormState>();

//Controllers for each text field in pop up

TextEditingController field1 = TextEditingController();
TextEditingController field2 = TextEditingController();
TextEditingController field3 = TextEditingController();
TextEditingController field4 = TextEditingController();

_retrieveinfo() async {
  // this is how we will save the inputted data to firebase
  // method is referenced in openDialog code for when submit is pressed

  final authUser = await FirebaseAuth.instance.currentUser;

  final workout = <String, dynamic>{
    "user": authUser?.uid,
    "name": field1.text,
    "weight": int.parse(field2.text),
    "sets": int.parse(field3.text),
    "reps": int.parse(field4.text)
  };

  await FirebaseFirestore.instance
      .collection("workout information")
      .where("user", isEqualTo: authUser?.uid)
      .get()
      .then(
    (querySnapshot) {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');
      }
    },
    onError: (e) => print("Error completing: $e"),
  );
}

_submitInfo() async {
  // used to retrieve data from a specific user for previous workouts
  final authUser = await FirebaseAuth.instance.currentUser;

  final workout = <String, dynamic>{
    "user": authUser?.uid,
    "name": field1.text,
    "weight": int.parse(field2.text),
    "sets": int.parse(field3.text),
    "reps": int.parse(field4.text)
  };

  if (authUser != null) {
    await FirebaseFirestore.instance
        .collection('workout information')
        .doc(authUser.uid)
        .set(workout);
  }
}

String?
    workoutName; // used to reset text field for name when entering new workout

Future openDialog(context) => showDialog(
      context: context,
      //pop up dialog for when user presses one of the specific muscle buttons
      builder: (context) => AlertDialog(
        title: const Text('Enter workout information'),
        content: Form(
          //Code to display a form style which also allows user
          //to enter information as well as an optional name for workout
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // creates a list of textfields
            TextFormField(
              controller: field1,
              //optional textfield to enter name of workout (if user wants to keep track of such information)
              autofocus: true,
              decoration: const InputDecoration(hintText: 'Name*'),
              onChanged: (value) => workoutName = value,
            ),
            TextFormField(
                controller: field2,
                keyboardType:
                    TextInputType.number, //eliminates confusion of typing
                //in letters(strings) rather integers
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(
                      r'[0-9]')), //eliminates any chance of negative numbers being inputted
                ],
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Weight (lbs)'),
                validator: (value) {
                  // Check for weight input
                  if (value == null || value.isEmpty) {
                    return 'Please enter the weight';
                  }
                  return null;
                }),
            TextFormField(
                controller: field3,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                //enter the weight
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Sets'),
                validator: (value) {
                  // Check for empty value for sets
                  if (value == null || value.isEmpty) {
                    return 'Please enter the amount of sets';
                  }
                  return null;
                }),
            TextFormField(
                controller: field4,
                //enter amount of reps
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Reps'),
                validator: (value) {
                  // Checks for empty value of reps
                  if (value == null || value.isEmpty) {
                    return 'Please enter the number of reps';
                  }
                  return null;
                }),
          ]),
        ),
        actions: [
          //allows user to submit information or cancel if they choose to go back
          TextButton(
            child: const Text(
                'CANCEL'), //User presses this button to cancel/back out if they desire
            onPressed: () {
              Navigator.of(context)
                  .pop(); //pops the form field and user can return to muscle group screen
            },
          ),
          TextButton(
            child: const Text(
                //User presses this button to submit valid information
                'SUBMIT'),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                //if user submissions are valid, saves information to database
                //and allows user to move on to next input/next screen
                _submitInfo();
                Navigator.of(context).pop();
                SnackBar mySnack = const SnackBar(
                    content: Text(
                        'Information Saved!'), //Displays confirmation message once user submits information on bottom of screen
                    backgroundColor: Colors.green);
                ScaffoldMessenger.of(context).showSnackBar(mySnack);
              }
            },
            //action that allows user to return to specific muscle group screen
          )
        ],
      ),
    );
