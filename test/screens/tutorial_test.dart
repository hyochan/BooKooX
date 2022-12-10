import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wecount/screens/tutorial.dart' show Tutorial;
import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets('Button', (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: const Tutorial()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);

    expect(findByText.evaluate().isEmpty, false);
    expect(find.text('Record it'), findsOneWidget);
    expect(find.text('Able to manage and\nshare ledger with friends'),
        findsNothing);
    expect(find.text('Share it'), findsNothing);
    expect(
        find.text(
            'Analyze graph at a glance.\nYou can manage your income and expenses.'),
        findsNothing);
    expect(find.text('Take care'), findsNothing);
  });

  testWidgets('Change pages when [Next] clicked', (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: const Tutorial()));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Share it'), findsOneWidget);

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();
    // verify(TestUtils.observer.didPush(any, any));

    expect(find.text('Take care'), findsOneWidget);
    expect(
        find.text(
            'Analyze graph at a glance.\nYou can manage your income and expenses.'),
        findsOneWidget);
  });
}
