import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bookoox/screens/home_setting.dart' show HomeSetting;

import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets("Widget", (WidgetTester tester) async{
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: HomeSetting()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text('CURRENCY'), findsOneWidget);
    expect(find.text('EXPORT_EXCEL'), findsOneWidget);
  });
}
