import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_palestra/features/exercises/domain/entities/exercise.dart';
import 'package:app_palestra/features/exercises/domain/repositories/exercise_repository.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final SupabaseClient _client;

  ExerciseRepositoryImpl(this._client);

  @override
  Future<List<Exercise>> getExercises({
    String? category,
    String? equipment,
    String? difficulty,
    String? searchQuery,
  }) async {
    var query = _client.from('exercises').select();

    if (category != null) {
      query = query.eq('muscle_group', category);
    }
    if (equipment != null) {
      query = query.eq('equipment', equipment);
    }
    if (difficulty != null) {
      query = query.eq('difficulty', difficulty);
    }
    if (searchQuery != null && searchQuery.isNotEmpty) {
      query = query.ilike('name', '%$searchQuery%');
    }

    try {
      final List<dynamic> response = await query;
      return response.map((e) => Exercise.fromJson(e)).toList();
    } catch (e) {
      // Mock Data for Demo if DB not set up
      await Future.delayed(const Duration(milliseconds: 500));
      var mocks = _mockExercises;
      if (category != null) {
        mocks = mocks.where((e) => e.muscleGroup == category).toList();
      }
      if (equipment != null) {
        mocks = mocks.where((e) => e.equipment == equipment).toList();
      }
      if (difficulty != null) {
        mocks = mocks.where((e) => e.difficulty == difficulty).toList();
      }
      if (searchQuery != null) {
        mocks = mocks
            .where(
              (e) => e.name.toLowerCase().contains(searchQuery.toLowerCase()),
            )
            .toList();
      }
      return mocks;
    }
  }

  static const _mockExercises = [
    Exercise(
      id: '1',
      name: 'Push Up',
      muscleGroup: 'Chest',
      equipment: 'Bodyweight',
      difficulty: 'Beginner',
      description: 'Standard push up',
    ),
    Exercise(
      id: '2',
      name: 'Squat',
      muscleGroup: 'Legs',
      equipment: 'Barbell',
      difficulty: 'Intermediate',
      description: 'Back squat',
    ),
    Exercise(
      id: '3',
      name: 'Pull Up',
      muscleGroup: 'Back',
      equipment: 'Pull-up Bar',
      difficulty: 'Intermediate',
      description: 'Wide grip pull up',
    ),
    Exercise(
      id: '4',
      name: 'Plank',
      muscleGroup: 'Abs',
      equipment: 'Bodyweight',
      difficulty: 'Beginner',
      description: 'Core stability',
    ),
    Exercise(
      id: '5',
      name: 'Deadlift',
      muscleGroup: 'Back',
      equipment: 'Barbell',
      difficulty: 'Advanced',
      description: 'Conventional deadlift',
    ),
    Exercise(
      id: '6',
      name: 'Dumbbell Press',
      muscleGroup: 'Shoulders',
      equipment: 'Dumbbell',
      difficulty: 'Intermediate',
      description: 'Seated press',
    ),
  ];
}
