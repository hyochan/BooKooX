import 'package:wecount/screens/home_calendar.dart' show HomeCalendar;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_utils.dart' show TestUtils;

const double PORTRAIT_WIDTH = 400.0;
const double PORTRAIT_HEIGHT = 800.0;
const double LANDSCAPE_WIDTH = PORTRAIT_HEIGHT;
const double LANDSCAPE_HEIGHT = PORTRAIT_WIDTH;

void main() {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'Show [Ledgers] on the date when the corresponding date has been clicked',
      (WidgetTester tester) async {
    await binding.setSurfaceSize(Size(PORTRAIT_WIDTH, PORTRAIT_HEIGHT));

    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: HomeCalendar()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);

    expect(find.text('EXERCISE'), findsNothing);
    expect(find.text('WALLET_MONEY'), findsNothing);
    expect(find.text('DATING'), findsNothing);
    expect(find.text('CAFE'), findsNothing);

    expect(find.text('10'), findsNWidgets(1));

    await tester.tap(find.text('10'));
    await tester.pumpAndSettle();

    // expect(find.text('EXERCISE'), findsOneWidget);
    // expect(find.text('WALLET_MONEY'), findsOneWidget);
    // expect(find.text('DATING'), findsOneWidget);
    // expect(find.text('CAFE'), findsNWidgets(3));
  });
}
