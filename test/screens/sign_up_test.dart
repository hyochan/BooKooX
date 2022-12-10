import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wecount/screens/sign_up.dart' show SignUp;
import 'package:wecount/widgets/button.dart';
import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets('Widget', (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: const SignUp()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
    expect(find.text('Sign up'), findsWidgets);
  });

  testWidgets('Show [emailError] text when email address is not a valid form',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: const SignUp()));
    await tester.pumpAndSettle();

    Finder emailField = find.byKey(const Key('email'));
    await tester.enterText(emailField, 'aa@aa');

    Finder passwordField = find.byKey(const Key('password'));
    await tester.enterText(passwordField, 'aaaaaa');

    // ignore: todo
    // TODO: Should mock firebase in order to survive below codes

    // await tester.tap(find.text('signUp').last);
    // await tester.pumpAndSettle();

    // expect(find.text('noValidEmail'), findsOneWidget);
  });

  testWidgets('Show [passwordError] text when password is not valid form',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: const SignUp()));
    await tester.pumpAndSettle();

    Finder emailField = find.byKey(const Key('email'));
    await tester.enterText(emailField, 'aa@aa.aa');

    Finder passwordField = find.byKey(const Key('password'));
    await tester.enterText(passwordField, 'aaaaaa');

    await tester.tap(find.text('Sign up').last, warnIfMissed: false);
    await tester.pumpAndSettle();

    expect(find.text('Please confirm password'), findsOneWidget);
  });

  testWidgets('Show [passwordConfirmError] text when password is not confirmed',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: const SignUp()));
    await tester.pumpAndSettle();

    Finder emailField = find.byKey(const Key('email'));
    await tester.enterText(emailField, 'aa@aa.aa');

    Finder passwordField = find.byKey(const Key('password'));
    await tester.enterText(passwordField, 'aaaaaa12');

    Finder passwordConfirmField = find.byKey(const Key('password-confirm'));
    await tester.enterText(passwordConfirmField, 'aaaaaa');

    var button = find.textContaining('Sign up');

    await tester.press(button);
    await tester.pumpAndSettle();

    expect(find.text('Please confirm password'), findsNWidgets(1));
  });
}
