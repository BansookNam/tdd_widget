import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

extension WidgetTesterExt on WidgetTester {
  Future pumpWidgetWithMaterialApp(Widget widget) {
    return pumpWidget(MaterialApp(home: Material(child: widget)));
  }
}
