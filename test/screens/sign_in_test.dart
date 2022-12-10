import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wecount/screens/sign_in.dart' show SignIn;
import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets('Widget', (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: const SignIn()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);
    expect(find.text('Sign in'), findsNWidgets(2));
    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });

  testWidgets('Show `errorEmail` text when email is not validated',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: const SignIn()));
    await tester.pumpAndSettle();

    Finder emailField = find.byKey(const Key('email'));
    await tester.enterText(emailField, 'aa@aa');

    Finder passwordField = find.byKey(const Key('password'));
    await tester.enterText(passwordField, 'aaaaaa');

    // ignore: todo
    // TODO: Should mock firebase in order to survive below codes
    // await tester.tap(signInBtn);
    // await tester.pumpAndSettle();

    // expect(find.text(t('noValidEmail')), findsOneWidget);
  });

  // testWidgets('Do not show [AlertDialog] when email is validated',
  //     (WidgetTester tester) async {
  //   await tester
  //       .pumpWidget(TestUtils.makeTestableWidget(child: const SignIn()));
  //   await tester.pumpAndSettle();

  //   Finder emailField = find.byKey(const Key('email'));
  //   await tester.enterText(emailField, 'aa@aa.aa');

  //   Finder passwordField = find.byKey(const Key('password'));
  //   await tester.enterText(passwordField, 'aaaaaa');

  //   await tester.tap(find.text(t('signIn')).last);
  //   await tester.pumpAndSettle();

  //   expect(find.byType(AlertDialog), findsNothing);
  // });
}
