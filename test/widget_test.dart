import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/befit.dart';
import 'package:mp5/views/exercisedetails.dart';
import 'package:mp5/views/filter.dart';
import 'package:mp5/views/saved.dart';

void main() {
  testWidgets('FilterPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: FilterPage(),
    ));

    // Verify that FilterPage has the expected widgets.
    expect(find.text('Select Type'), findsOneWidget);
    expect(find.text('Select Muscle'), findsOneWidget);
    expect(find.text('Select Difficulty'), findsOneWidget);
    expect(find.text('Submit'), findsOneWidget);
  });

  testWidgets('BeFit UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: BeFit(null, null, null, []),
    ));

    // Verify that BeFit has the expected widgets.
    expect(find.text('Be Fit'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('SavedPage UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: SavedPage([], key: GlobalKey()),
    ));

    // Verify that SavedPage has the expected widgets.
    expect(find.text('Your Workout'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('ExerciseDetails UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: ExerciseDetails(exercise: {'name': 'Test Exercise'}),
    ));

    // Verify that ExerciseDetails has the expected widgets.
    expect(find.text('Exercise Details'), findsOneWidget);
    expect(find.text('NAME:\nTest Exercise'), findsOneWidget);
  });

  testWidgets('BottomNavigationBar Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: FilterPage(),
    ));

    // Verify that BottomNavigationBar has the expected widgets.
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byIcon(Icons.home), findsOneWidget);
    expect(find.byIcon(Icons.bookmark_add_sharp), findsOneWidget);
  });
}
