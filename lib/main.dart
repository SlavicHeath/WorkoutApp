import 'package:flutter/material.dart';

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

  int currentIndex = 0;

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

  int currentIndex = 0;

  final ButtonStyle workoutButton = ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      foregroundColor: Colors.black,
      shape: const StadiumBorder(),
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: currentIndex == 1
            ? const Center(child: Text('SELECT MUSCLE GROUP'))
            : const SizedBox(),
      ),
      body: Center(
        child: currentIndex == 1
            ? Container(
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
                              style: const TextStyle(color: Colors.black)),
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
                              style: const TextStyle(color: Colors.black)),
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
                              style: const TextStyle(color: Colors.black)),
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
                              style: const TextStyle(color: Colors.black)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: 'Previous',
            icon: Icon(Icons.arrow_back_ios_new_outlined),
          ),
          BottomNavigationBarItem(
            label: 'Workouts',
            icon: Icon(Icons.workspaces_sharp),
          )
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
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

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Enter Information below'),
            content: TextFormField(
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Enter Weight')),
            actions: [
              TextButton(
                child: const Text('SUBMIT'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('ARMS')),
        ),
        body: Center(
            child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 75,
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      openDialog();
                    },
                    child: Text(armName1),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      openDialog();
                    },
                    child: Text(armName2),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      openDialog();
                    },
                    child: Text(armName3),
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

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Enter Information below'),
            content: TextFormField(
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Enter Weight')),
            actions: [
              TextButton(
                child: const Text('SUBMIT'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ]),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('LEGS')),
        ),
        body: Center(
            child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 75,
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      openDialog();
                    },
                    child: Text(legName1),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ElevatedButton(
                    onPressed: () {
                      openDialog();
                    },
                    child: Text(legName2),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      openDialog();
                    },
                    child: Text(legName3),
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

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Enter Information below'),
            content: TextFormField(
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Enter Weight')),
            actions: [
              TextButton(
                child: const Text('SUBMIT'),
                onPressed: () {
                  Navigator.of(context).pop();
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
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 75,
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      openDialog();
                    },
                    child: Text(backName1),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      openDialog();
                    },
                    child: Text(backName2),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      openDialog();
                    },
                    child: Text(backName3),
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

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Enter Information below'),
            content: TextFormField(
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Enter Weight')),
            actions: [
              TextButton(
                child: const Text('SUBMIT'),
                onPressed: () {
                  Navigator.of(context).pop();
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
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 75,
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      openDialog();
                    },
                    child: Text(chestName1),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      openDialog();
                    },
                    child: Text(chestName2),
                  ),
                ),
              ),
              SizedBox(
                height: 75,
                width: 110,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () {
                      openDialog();
                    },
                    child: Text(chestName3),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
