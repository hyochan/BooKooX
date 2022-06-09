import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wecount/screens/sign_in.dart' show SignIn;
import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets("Widget", (WidgetTester tester) async {
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: SignIn()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
//     print(findByText.evaluate());
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text('SIGN_IN'), findsNWidgets(2));
    expect(find.text('EMAIL'), findsOneWidget);
    expect(find.text('EMAIL_HINT'), findsOneWidget);
    expect(find.text('PASSWORD'), findsOneWidget);
    expect(find.text('PASSWORD_HINT'), findsOneWidget);
  });
  testWidgets("Show `errorEmail` text when email is not validated",
      (WidgetTester tester) async {
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: SignIn()));
    await tester.pumpAndSettle();

    Finder emailField = find.byKey(new Key('email'));
    await tester.enterText(emailField, 'aa@aa');

    Finder passwordField = find.byKey(new Key('password'));
    await tester.enterText(passwordField, 'aaaaaa');

    Finder signInBtn = find.byKey(new Key('sign-in-button'));

    // TODO: Should mock firebase in order to survive below codes

    // await tester.tap(signInBtn);
    // await tester.pumpAndSettle();

    // expect(find.text('NO_VALID_EMAIL'), findsOneWidget);
  });
  testWidgets("Do not show [AlertDialog] when email is validated",
      (WidgetTester tester) async {
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: SignIn()));
    await tester.pumpAndSettle();

    Finder emailField = find.byKey(new Key('email'));
    await tester.enterText(emailField, 'aa@aa.aa');

    Finder passwordField = find.byKey(new Key('password'));
    await tester.enterText(passwordField, 'aaaaaa');

    await tester.tap(find.text('SIGN_IN').last);
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
  });
}
