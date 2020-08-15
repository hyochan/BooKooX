import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:bookoox/screens/main_empty.dart' show MainEmpty;
import 'package:bookoox/screens/ledger_edit.dart' show LedgerEdit;
import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets("Widget", (WidgetTester tester) async{
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: MainEmpty()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text('NO_LEDGER_DESCRIPTION'), findsNWidgets(1));
    expect(find.text('ADD_LEDGER'), findsNWidgets(1));
  });
  testWidgets("Navigate to [LedgerEdit] when addLedger pressed", (WidgetTester tester) async{
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: MainEmpty()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('ADD_LEDGER'));
    await tester.pumpAndSettle();

    verify(TestUtils.observer.didPush(any, any));
    expect(find.byType(LedgerEdit), findsOneWidget);
  });
}
