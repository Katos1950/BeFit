import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mp5/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('BeFit App Integration Test', () {
    testWidgets('Navigate to Saved Page and back to Home',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to Saved Page
      await tester.tap(find.byIcon(Icons.bookmark_add_sharp));
      await tester.pumpAndSettle();

      expect(find.text('Saved'), findsOneWidget);

      // Navigate back to Home
      await tester.tap(find.byIcon(Icons.home));
      await tester.pumpAndSettle();

      expect(find.text('Welcome to BeFit'), findsOneWidget);
    });

    testWidgets('Filter Exercises and Navigate to Details',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Filter exercises
      await tester.tap(find.text('Select Type'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('cardio').last);
      await tester.pumpAndSettle();

      // Submit filter
      await tester.tap(find.text('Submit'));
      await tester.pumpAndSettle();

      // Verify filtered exercises are displayed
      expect(find.text('Be Fit'), findsOneWidget);

      // Navigate to Exercise Details
      await tester.tap(find.byType(ListTile).first);
      await tester.pumpAndSettle();

      expect(find.text('Exercise Details'), findsOneWidget);
    });

  });
}
