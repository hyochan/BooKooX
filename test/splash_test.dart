import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bookoo2/screens/splash.dart';
import './test_utils.dart' show TestUtils;

void main() {
  testWidgets('Widget', (WidgetTester tester) async {
    await tester.pumpWidget(
      TestUtils.makeTestableWidget(child: Splash()),
      Duration(seconds: 1),
    );

    var finderByType = find.byType(Text);
    print(finderByType.evaluate());
    await tester.pumpWidget(Placeholder());
  });
}
