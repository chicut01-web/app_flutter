import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_palestra/features/exercises/data/repositories/exercise_repository_impl.dart';
import 'package:app_palestra/features/exercises/domain/entities/exercise.dart';
import 'package:app_palestra/features/exercises/domain/repositories/exercise_repository.dart';

// Repos
final exerciseRepositoryProvider = Provider<ExerciseRepository>((ref) {
  return ExerciseRepositoryImpl(Supabase.instance.client);
});

// Filter State
class ExerciseFilter {
  final String? category;
  final String? equipment;
  final String? difficulty;
  final String? searchQuery;

  const ExerciseFilter({
    this.category,
    this.equipment,
    this.difficulty,
    this.searchQuery,
  });

  ExerciseFilter copyWith({
    String? category,
    String? equipment,
    String? difficulty,
    String? searchQuery,
  }) {
    return ExerciseFilter(
      category: category ?? this.category,
      equipment: equipment ?? this.equipment,
      difficulty: difficulty ?? this.difficulty,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ExerciseFilterNotifier extends Notifier<ExerciseFilter> {
  @override
  ExerciseFilter build() {
    return const ExerciseFilter();
  }

  void update(ExerciseFilter Function(ExerciseFilter state) cb) {
    state = cb(state);
  }
}

final exerciseFilterProvider =
    NotifierProvider<ExerciseFilterNotifier, ExerciseFilter>(
      ExerciseFilterNotifier.new,
    );

// Exercises List Provider
final exercisesListProvider = FutureProvider<List<Exercise>>((ref) async {
  final repo = ref.watch(exerciseRepositoryProvider);
  final filter = ref.watch(exerciseFilterProvider);

  return repo.getExercises(
    category: filter.category,
    equipment: filter.equipment,
    difficulty: filter.difficulty,
    searchQuery: filter.searchQuery,
  );
});
