import 'package:flutter_test/flutter_test.dart';
import 'package:mshwar_passenger/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MshwarApp());
    expect(find.byType(MshwarApp), findsOneWidget);
  });
}
