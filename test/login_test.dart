import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bookoo2/screens/login.dart' show Login;
import './test_utils.dart' show TestUtils;

void main() {
  testWidgets("Widget", (WidgetTester tester) async{
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: Login()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
//     print(findByText.evaluate());
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text('LOGIN'), findsNWidgets(2));
    expect(find.text('EMAIL'), findsOneWidget);
    expect(find.text('EMAIL_HINT'), findsOneWidget);
    expect(find.text('PASSWORD'), findsOneWidget);
    expect(find.text('PASSWORD_HINT'), findsOneWidget);
  });
  testWidgets("Show [AlertDialog] when email is not validated", (WidgetTester tester) async{
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: Login()));
    await tester.pumpAndSettle();

    Finder emailField = find.byKey(new Key('email'));
    await tester.enterText(emailField, 'aa@aa');

    Finder passwordField = find.byKey(new Key('password'));
    await tester.enterText(passwordField, 'aaaaaa');

    await tester.tap(find.text('LOGIN').last);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
  });
  testWidgets("Do not show [AlertDialog] when email is validated", (WidgetTester tester) async{
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: Login()));
    await tester.pumpAndSettle();

    Finder emailField = find.byKey(new Key('email'));
    await tester.enterText(emailField, 'aa@aa.aa');

    Finder passwordField = find.byKey(new Key('password'));
    await tester.enterText(passwordField, 'aaaaaa');

    await tester.tap(find.text('LOGIN').last);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
  });
}
