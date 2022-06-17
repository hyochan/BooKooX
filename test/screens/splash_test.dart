import 'package:flutter_test/flutter_test.dart';

import 'package:wecount/screens/splash.dart';
import '../test_utils.dart' show TestUtils;

void main() {
  late Future future;

  setUp(() {
    future = new Future.value();
  });

  testWidgets('Widget', (WidgetTester tester) async {
    await tester.pumpWidget(TestUtils.makeTestableWidget(child: Splash()));
    await tester.runAsync(() => future);

//     var finderByType = find.byType(Image);
//     expect(finderByType, findsOneWidget);
  });
}
