import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_palestra/features/exercises/presentation/providers/exercises_provider.dart';
import 'package:app_palestra/features/exercises/domain/entities/exercise.dart';
import 'package:app_palestra/features/exercises/presentation/pages/exercise_detail_page.dart';

class ExercisesPage extends ConsumerWidget {
  const ExercisesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncExercises = ref.watch(exercisesListProvider);
    final filter = ref.watch(exerciseFilterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Exercise Library')),
      body: Column(
        children: [
          // Search & Filters
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search exercises...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onChanged: (value) {
                ref
                    .read(exerciseFilterProvider.notifier)
                    .update((state) => state.copyWith(searchQuery: value));
              },
            ),
          ),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _FilterChip(
                  label: 'Chest',
                  isSelected: filter.category == 'Chest',
                  onSelected: (selected) {
                    ref
                        .read(exerciseFilterProvider.notifier)
                        .update(
                          (state) => state.copyWith(
                            category: selected ? 'Chest' : null,
                          ),
                        );
                  },
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Back',
                  isSelected: filter.category == 'Back',
                  onSelected: (selected) {
                    ref
                        .read(exerciseFilterProvider.notifier)
                        .update(
                          (state) => state.copyWith(
                            category: selected ? 'Back' : null,
                          ),
                        );
                  },
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Legs',
                  isSelected: filter.category == 'Legs',
                  onSelected: (selected) {
                    ref
                        .read(exerciseFilterProvider.notifier)
                        .update(
                          (state) => state.copyWith(
                            category: selected ? 'Legs' : null,
                          ),
                        );
                  },
                ),
                const SizedBox(width: 8),
                _FilterChip(
                  label: 'Advanced',
                  isSelected: filter.difficulty == 'Advanced',
                  onSelected: (selected) {
                    ref
                        .read(exerciseFilterProvider.notifier)
                        .update(
                          (state) => state.copyWith(
                            difficulty: selected ? 'Advanced' : null,
                          ),
                        );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // List
          Expanded(
            child: asyncExercises.when(
              data: (exercises) {
                if (exercises.isEmpty) {
                  return const Center(child: Text('No exercises found.'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    return _ExerciseCard(exercise: exercise);
                  },
                );
              },
              error: (err, stack) => Center(child: Text('Error: $err')),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(bool) onSelected;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      checkmarkColor: Colors.white,
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final Exercise exercise;

  const _ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(Icons.fitness_center, color: theme.colorScheme.primary),
        ),
        title: Text(
          exercise.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text('${exercise.muscleGroup} • ${exercise.difficulty}'),
            if (exercise.description != null) ...[
              const SizedBox(height: 4),
              Text(
                exercise.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall,
              ),
            ],
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ExerciseDetailPage(exercise: exercise),
            ),
          );
        },
      ),
    );
  }
}
