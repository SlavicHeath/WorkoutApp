import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workoutpet/battle.dart';
import 'package:workoutpet/main.dart';
import 'package:workoutpet/sign_in.dart';

import 'character_select.dart';

void main() => runApp(const MyApp());

///
/// [MyApp.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		StatefulWidget]
/// [@global]
///
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

///
/// [_MyAppState.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		State]
/// [@global]
///
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WorkoutPage(),
    );
  }
}

///
/// [WorkoutPage.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		StatefulWidget]
/// [@global]
///
class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

///
/// [_WorkoutPageState.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		State]
/// [@global]
///
class _WorkoutPageState extends State<WorkoutPage> {
  int currindex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('SELECT MUSCLE GROUP')),
        backgroundColor: Colors.purple,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer header telling which user is signed in
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black87),
              child: Text(
                "Signed in as: ${FirebaseAuth.instance.currentUser?.email}",
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(
                    context); //To close the drawer wwhen moving to the next page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => WorkoutPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list),
              title: Text("Battle"),
              onTap: () {
                Navigator.pop(
                    context); //To close the drawer wwhen moving to the next page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UserStatsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.login),
              title: Text("Signout"),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
          child: currindex ==
                  1 // dont want user to click workout page and immediately go to previous
              // put on 1 so that it's on the body part screen
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                          controller: field5,
                          decoration: null,
                          style: TextStyle(color: Colors.transparent),
                          enabled: false),
                      SizedBox(
                        height: 100,
                        width: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            style: workoutButton,
                            onPressed: () {
                              final button = buttonName;
                              field5.text = button;
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
                              final button = butt2Name;
                              field5.text = button;
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
                              final button = butt3Name;
                              field5.text = button;
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
                              final button = butt4Name;
                              field5.text = button;
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
                )
              : currindex == 0
                  ? PrevWorkPage()
                  : CurrentWorkPage()),
      bottomNavigationBar: BottomNavigationBar(
          //used to navigate within workout page
          // previous button used to see previous workouts
          // current button used to show the workouts the user just inputted whilst logged in for that day/time
          backgroundColor: Colors.purple,
          selectedItemColor: Colors.black,
          currentIndex: currindex,
          items: const [
            BottomNavigationBarItem(
              label: 'Previous',
              icon: Icon(Icons.arrow_back_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Information',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'current',
              icon: Icon(Icons.accessibility_new_rounded),
            )
          ],
          onTap: (int index) {
            //changes the index so that way the screen changes and user is able to see each container
            setState(() {
              currindex = index;
            });
          }),
    );
  }
}

///
/// [ArmPage.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		WorkoutPage]
/// [@global]
///
class ArmPage extends WorkoutPage {
  const ArmPage({super.key});

  @override
  State<ArmPage> createState() => _ArmPageState();
}

///
/// [_ArmPageState.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		State]
/// [@global]
///
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

///
/// [LegPage.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		StatefulWidget]
/// [@global]
///
class LegPage extends StatefulWidget {
  const LegPage({super.key});

  @override
  State<LegPage> createState() => _LegPageState();
}

///
/// [_LegPageState.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		State]
/// [@global]
///
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

///
/// [BackPage.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		StatefulWidget]
/// [@global]
///
class BackPage extends StatefulWidget {
  const BackPage({super.key});

  @override
  State<BackPage> createState() => _BackPageState();
}

///
/// [_BackPageState.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		State]
/// [@global]
///
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

///
/// [ChestPage.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		StatefulWidget]
/// [@global]
///
class ChestPage extends StatefulWidget {
  const ChestPage({super.key});

  @override
  State<ChestPage> createState() => _ChestPageState();
}

///
/// [_ChestPageState.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		State]
/// [@global]
///
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

//Current workout page which the current button on navigation part points to
class CurrentWorkPage extends StatefulWidget {
  CurrentWorkPage({super.key});

  ///
  /// [_CurrentWorkPageState.]
  ///
  /// [@author	Unknown]
  /// [ @since	v0.0.1 ]
  /// [@version	v1.0.0	Tuesday, April 4th, 2023]
  /// [@see		State]
  /// [@global]
  ///

  @override
  _CurrentWorkPageState createState() => _CurrentWorkPageState();
}

class _CurrentWorkPageState extends State<CurrentWorkPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CURRENT WORKOUTS'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: StreamBuilder(
            //Calls into firebase to retrieve data from workout info document
            stream: FirebaseFirestore.instance
                .collection('workout information')
                .where('user', isEqualTo: authUser!.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                // Will prompt user that there's no data therefore no previous workouts
                return const Center(
                  child: Text('No current workouts selected'),
                );
              }
              return ListView(
                children: snapshot.data!.docs.map((document) {
                  return Card(
                    child: ListTile(
                      //displays previous workouts in a tile list format
                      autofocus: true,
                      leading: Text(document['body part']),
                      title: Text(document[
                          'name']), // $ allows integer data to be read in
                      subtitle: Text(
                          '${document['weight']} lbs ${document['reps']} reps ${document['sets']} sets'),
                      trailing: Container(
                          child: IconButton(
                        onPressed: () {
                          //Pops up an alert dialog asking the user to confirm deletion of workout
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text('Confirm deletion'),
                                    content: const Text(
                                        "Are you sure you want to delete workout?"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    //The right side is the widget you want to go to
                                                    builder: (context) =>
                                                        WorkoutPage())); //if user selects no, sends user back to current workout page
                                          },
                                          child: const Text('no')),
                                      TextButton(
                                          onPressed: () {
                                            //otherwise, we access the collection using the specific document ID each workout gets, and remove it promptly
                                            FirebaseFirestore.instance
                                                .collection(
                                                    'workout information')
                                                .doc(document.id)
                                                .delete()
                                                .whenComplete(() {
                                              print('deleted successfully');
                                            });
                                            setState(() {});
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('yes')),
                                    ],
                                  ));
                        },
                        icon: Icon(Icons.close),
                      )),
                      tileColor: Colors.purple,
                    ),
                  );
                }).toList(),
              );
            },
          )),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    //The right side is the widget you want to go to
                    builder: (context) => UserStatsScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              fixedSize: const Size(100, 50),
              backgroundColor: Colors.purple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text("Battle!"),
          ),
        ],
      ),
    );
  }
}

//Previous Workout page associated with previous button icon
class PrevWorkPage extends StatefulWidget {
  PrevWorkPage({super.key});

  @override
  _PrevWorkPageState createState() => _PrevWorkPageState();
}

///
/// [_PrevWorkPageState.]
///
/// [@author	Unknown]
/// [ @since	v0.0.1 ]
/// [@version	v1.0.0	Tuesday, April 4th, 2023]
/// [@see		State]
/// [@global]
///
class _PrevWorkPageState extends State<PrevWorkPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PREVIOUS WORKOUTS'),
        backgroundColor: Colors.purple,
      ),
      body: StreamBuilder(
        //Calls into firebase to retrieve data from workout info document
        stream: FirebaseFirestore.instance
            .collection('workout information')
            .where('user', isEqualTo: authUser!.uid)
            .snapshots(),
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
                  leading: Text(document['body part']),
                  title: Text(
                      '${document['weight']} lbs'), // $ allows integer data to be read in
                  subtitle:
                      Text('${document['reps']} reps ${document['sets']} sets'),
                  trailing: Text(document['name']),
                  onTap: () {},
                  tileColor: Colors.purple,
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
TextEditingController field5 = TextEditingController();

final authUser = FirebaseAuth.instance.currentUser;

_submitInfo() async {
  // used to retrieve data from a specific user for previous workouts

  final workout = <String, dynamic>{
    "user": authUser?.uid,
    "name": field1.text,
    "weight": int.parse(field2.text),
    "sets": int.parse(field3.text),
    "reps": int.parse(field4.text),
    "body part": field5.text
  };

  if (authUser != null) {
    await FirebaseFirestore.instance
        .collection('workout information')
        .add(workout)
        .then((value) => print(" Information added"))
        .catchError((error) => print("Failed to add: $error"));
  }
}

// used to reset text field for name when entering new workout
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
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  // Check for weight input
                  if (value == null || value.isEmpty) {
                    return 'Please enter workout Name';
                  }
                  return null;
                }),
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
              field1.clear();
              field2
                  .clear(); //Clears the text fields so user can enter new information everytime they press button
              field3.clear();
              field4.clear();
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

                field1.clear();
                field2
                    .clear(); //Clears the text fields so user can enter new information everytime they press button
                field3.clear();
                field4.clear();

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
