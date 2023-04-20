import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:workoutpet/main.dart' as app;
import 'package:workoutpet/sign_in.dart';

void main() {
  testWidgets('finds a widget using a Key', (tester) async {
    const testKey = Key('ryan.lehner@gmail.com');
    await tester.pumpWidget(MaterialApp(key: testKey, home: Container()));

    // Find the MaterialApp widget using the testKey.
    expect(find.byKey(testKey), findsOneWidget);
  });
}
