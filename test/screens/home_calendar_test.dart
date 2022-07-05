import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wecount/screens/home_calendar.dart' show HomeCalendar;

import '../test_utils.dart' show TestUtils;

const double portraitWidth = 400.0;
const double portraitHeight = 800.0;
const double landscapeWidth = portraitHeight;
const double landscapeHeight = portraitWidth;

void main() {
  final TestWidgetsFlutterBinding binding =
      TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'Show [Ledgers] on the date when the corresponding date has been clicked',
      (WidgetTester tester) async {
    await binding.setSurfaceSize(const Size(portraitWidth, portraitHeight));

    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: const HomeCalendar()));
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
