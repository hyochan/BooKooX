import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bookoo2/screens/intro.dart';
import './test_utils.dart' show TestUtils;

void main() {
  testWidgets('Widget', (WidgetTester tester) async {
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: Intro()));
    await tester.pumpAndSettle();

    expect(find.text('dooboolab'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    print(tester.widgetList(find.byType(Text)));

    var finderByType = find.byType(Text);
    print(finderByType.evaluate());
  });
}
