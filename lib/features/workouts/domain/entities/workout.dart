import 'package:app_palestra/features/exercises/domain/entities/exercise.dart';

class Workout {
  final String id;
  final String name;
  final String description;
  final List<Exercise> exercises; // Simplified for MVP

  const Workout({
    required this.id,
    required this.name,
    required this.description,
    required this.exercises,
  });
}
