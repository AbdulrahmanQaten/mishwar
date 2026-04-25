import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mshwar_driver/main.dart';

void main() {
  testWidgets('Driver app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MshwarDriverApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
