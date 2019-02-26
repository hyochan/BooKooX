import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bookoo2/screens/login.dart' show Login;
import './test_utils.dart' show TestUtils;

void main() {
  testWidgets("Widget", (WidgetTester tester) async{
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: Login()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    // print(findByText.evaluate());
    expect(findByText.evaluate().isEmpty, false);
    expect(find.text('LOGIN'), findsNWidgets(2));
    expect(find.text('EMAIL'), findsOneWidget);
    expect(find.text('PASSWORD'), findsOneWidget);
  });
}
