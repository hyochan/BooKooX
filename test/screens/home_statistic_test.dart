import 'package:bookoo2/screens/home_statistic/home_statistic.dart'
    show HomeStatistic;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pie_chart/pie_chart.dart' show PieChart;
import '../test_utils.dart' show TestUtils;

void main() {
  testWidgets('Show [Piechart] properly',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: HomeStatistic()));
    await tester.pumpAndSettle();

    var findByText = find.byType(Text);
    expect(findByText.evaluate().isEmpty, false);

    /// piechart exists
    expect(find.byType(PieChart), findsOneWidget);
  });

  testWidgets('Show proper texts on clicking [Income] and [Consume] tap on top',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(TestUtils.makeTestableWidget(child: HomeStatistic()));
    await tester.pumpAndSettle();

    /// click INCOME and count texts
    await tester.tap(find.text('INCOME'));
    await tester.pumpAndSettle();

    expect(find.text('EXERCISE'), findsOneWidget);
    expect(find.text('WALLET_MONEY'), findsNWidgets(2));
    expect(find.text('DATING'), findsOneWidget);
    expect(find.text('SALARY'), findsNWidgets(2));

    /// click CONSUME and count texts
    await tester.tap(find.text('CONSUME'));
    await tester.pumpAndSettle();

    expect(find.text('EXERCISE'), findsNWidgets(2));
    expect(find.text('WALLET_MONEY'), findsOneWidget);
    expect(find.text('DATING'), findsNWidgets(2));
    expect(find.text('SALARY'), findsOneWidget);
  });
}
