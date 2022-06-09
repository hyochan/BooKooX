import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:wecount/screens/intro.dart' show Intro;
import 'package:wecount/screens/sign_in.dart' show SignIn;
import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets("Widget", (WidgetTester tester) async {
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: Intro()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text('SIGN_IN'), findsNWidgets(1));
  });
  testWidgets("Navigate to [SignIn] when signIn pressed",
      (WidgetTester tester) async {
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: Intro()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('SIGN_IN'));
    await tester.pumpAndSettle();

    verify(TestUtils.observer.didPush(any, any));
    expect(find.byType(SignIn), findsOneWidget);
  });
}
