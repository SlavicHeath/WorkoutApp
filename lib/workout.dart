import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({super.key});

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('SELECT MUSCLE GROUP')),
        ),
        body: Center(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
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
                      onPressed: () {},
                      child: Text(buttonName),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(butt2Name),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(butt3Name),
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(butt4Name),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              label: 'Previous',
              icon: Icon(Icons.arrow_back_ios_new_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            )
          ],
          currentIndex: currentIndex,
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
