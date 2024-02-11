import 'package:flutter_test/flutter_test.dart';
import 'package:mp5/models/exercise.dart';

void main() {
  group('Exercise Model Tests', () {
    test('Exercise instantiation with parameters', () {
      final exercise = Exercise(
        'Test Name',
        'Test Type',
        'Test Muscle',
        'Test Equipment',
        'Test Difficulty',
        'Test Instructions',
      );

      expect(exercise.name, 'Test Name');
      expect(exercise.type, 'Test Type');
      expect(exercise.muscle, 'Test Muscle');
      expect(exercise.equipment, 'Test Equipment');
      expect(exercise.difficulty, 'Test Difficulty');
      expect(exercise.instructions, 'Test Instructions');
    });

    test('Exercise instantiation without parameters', () {
      final exercise = Exercise();

      expect(exercise.name, null);
      expect(exercise.type, null);
      expect(exercise.muscle, null);
      expect(exercise.equipment, null);
      expect(exercise.difficulty, null);
      expect(exercise.instructions, null);
    });

    test('Exercise apiUrl generation', () {
      final exercise = Exercise(
        'Test Name',
        'Test Type',
        'Test Muscle',
        'Test Equipment',
        'Test Difficulty',
        'Test Instructions',
      );

      expect(
        exercise.apiUrl,
        'https://api.api-ninjas.com/v1/exercises?muscle=Test Muscle&difficulty=Test Difficulty&type=Test Type',
      );
    });


    test('Exercise fetchExercises returns a list', () async {
      final exercise = Exercise();
      final result = await exercise.fetchExercises();

      expect(result, isA<List<dynamic>>());
    });

    test('Exercise SearchByName returns a list', () async {
      final exercise = Exercise();
      final result = await exercise.Searchbyname('Test Name');

      expect(result, isA<List<dynamic>>());
    });
  });
}
