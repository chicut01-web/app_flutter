import 'package:app_palestra/features/exercises/domain/entities/exercise.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> getExercises({
    String? category, // muscle group
    String? equipment,
    String? difficulty,
    String? searchQuery,
  });
}
