import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wecount/screens/ledger_item_edit.dart' show LedgerItemEdit;
import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets("Widget", (WidgetTester tester) async {
    await tester.pumpWidget(TestUtils.makeTestableWidget(
      child: const LedgerItemEdit(),
    ));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text('PRICE'), findsNWidgets(1));
    expect(find.text('CATEGORY'), findsNWidgets(1));
    expect(find.text('DATE'), findsNWidgets(1));
    expect(find.text('LOCATION'), findsNWidgets(1));
  });
  testWidgets("Navigate to [LedgerEdit] when addLedger pressed",
      (WidgetTester tester) async {
    // await tester.pumpWidget(TestUtils.makeTestableWidget(child: MainEmpty()));
    // await tester.pumpAndSettle();

    // await tester.tap(find.text('ADD_LEDGER'));
    // await tester.pumpAndSettle();

    // verify(TestUtils.observer.didPush(any, any));
    // expect(find.byType(LedgerEdit), findsOneWidget);
  });
}
