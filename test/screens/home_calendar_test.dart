
import 'package:bookoo2/screens/home_calendar.dart' show HomeCalendar;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets('Show [Ledgers] on the date when the corresponding date has been clicked', (WidgetTester tester) async {
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: HomeCalendar()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text('운동'), findsNothing);
    expect(find.text('용돈'), findsNothing);
    expect(find.text('데이트'), findsNothing);
    expect(find.text('커피'), findsNothing);

    expect(find.text('10'), findsNWidgets(1));

    await tester.tap(find.text('10'));
    await tester.pumpAndSettle();

    expect(find.text('운동'), findsOneWidget);
    expect(find.text('용돈'), findsOneWidget);
    expect(find.text('데이트'), findsOneWidget);
    expect(find.text('커피'), findsNWidgets(4));
  });
}
