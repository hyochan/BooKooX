
import 'package:bookoo2/screens/home_calendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Widget', (WidgetTester tester) async {
    await tester.pumpWidget(HomeCalendar());
    await tester.pumpAndSettle();
  });
}
