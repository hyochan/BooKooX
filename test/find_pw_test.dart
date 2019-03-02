import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bookoo2/screens/find_pw.dart' show FindPw;
import './test_utils.dart' show TestUtils;

void main() {
  testWidgets("Widget", (WidgetTester tester) async{
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: FindPw()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
//     print(findByText.evaluate());
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text('FIND_PASSWORD'), findsOneWidget);
    expect(find.text('EMAIL'), findsOneWidget);
    expect(find.text('EMAIL_HINT'), findsOneWidget);
  });
  testWidgets("Show [emailError] text when email address is not valid form", (WidgetTester tester) async{
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: FindPw()));
    await tester.pumpAndSettle();

    Finder emailField = find.byKey(new Key('email'));
    await tester.enterText(emailField, 'aa@aa');

    await tester.tap(find.text('SEND_EMAIL'));
    await tester.pumpAndSettle();

    expect(find.text('NO_VALID_EMAIL'), findsOneWidget);
  });
}
