import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bookoo2/screens/intro.dart' show Intro;
import './test_utils.dart' show TestUtils;

void main() {
  testWidgets("Widget", (WidgetTester tester) async{
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: Intro()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text('LOGIN'), findsNWidgets(1));
  });
}
