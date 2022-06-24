import 'package:wecount/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wecount/screens/category_add.dart' show CategoryAdd;
import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets("Widget", (WidgetTester tester) async {
    await tester.pumpWidget(
      TestUtils.makeTestableWidget(
        child: CategoryAdd(lastId: 100, categoryType: CategoryType.CONSUME),
      ),
    );
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text('CANCEL'), findsNWidgets(1));
    expect(find.text('DONE'), findsNWidgets(1));
    expect(find.text('ICON_SELECT'), findsNWidgets(1));
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
