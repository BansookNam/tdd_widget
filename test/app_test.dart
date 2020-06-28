// Imports the Flutter Driver API.
import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart' as ft;
import 'package:test/test.dart';

void main() {
  group('Drive Interaction', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
    final buttonFinder = find.byType("InkWell");
    // Tap the add button.

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('Tap right button', () async {
      // Use the `driver.getText` method to ver
      await driver.tap(buttonFinder);
      // Rebuild the widget with the new item.
      // Expect to find the item on screen.
      expect(ft.find.text('1'), ft.findsOneWidget);
    });
  });
}
