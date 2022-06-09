import 'package:wecount/models/Currency.dart';
import 'package:wecount/providers/CurrentLedger.dart';
import 'package:wecount/models/Ledger.dart';
import 'package:wecount/types/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wecount/screens/home_setting.dart' show HomeSetting;
import 'package:provider/provider.dart';

import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets("Widget", (WidgetTester tester) async {
    await tester.pumpWidget(TestUtils.makeTestableWidget(
      child: HomeSetting(),
    ));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text('CURRENCY'), findsOneWidget);
    expect(find.text('EXPORT_EXCEL'), findsOneWidget);
  });
}
