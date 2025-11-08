// This is a basic Flutter widget test for HabitKit

import 'package:flutter_test/flutter_test.dart';

import 'package:habitkit/main.dart';

void main() {
  testWidgets('App loads successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HabitKitApp());

    // Verify that the app title is displayed
    expect(find.text('HabitKit'), findsWidgets);
  });
}
