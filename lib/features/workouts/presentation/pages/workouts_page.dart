import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_palestra/features/workouts/domain/entities/workout.dart';
import 'package:app_palestra/features/exercises/domain/entities/exercise.dart';

// Mock Provider
final workoutsProvider = Provider<List<Workout>>((ref) {
  return [
    Workout(
      id: '1',
      name: 'Full Body A',
      description: 'Classic full body routine',
      exercises: [
        Exercise(
          id: '1',
          name: 'Squat',
          muscleGroup: 'Legs',
          equipment: 'Barbell',
          difficulty: 'Int',
        ),
        Exercise(
          id: '2',
          name: 'Bench Press',
          muscleGroup: 'Chest',
          equipment: 'Barbell',
          difficulty: 'Int',
        ),
        Exercise(
          id: '3',
          name: 'Row',
          muscleGroup: 'Back',
          equipment: 'Barbell',
          difficulty: 'Int',
        ),
      ],
    ),
    Workout(
      id: '2',
      name: 'Upper Body Power',
      description: 'Focus on strength',
      exercises: [],
    ),
    Workout(
      id: '3',
      name: 'Leg Hypertrophy',
      description: 'High rep leg day',
      exercises: [],
    ),
  ];
});

class WorkoutsPage extends ConsumerWidget {
  const WorkoutsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workouts = ref.watch(workoutsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Workouts')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Create New'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final workout = workouts[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Text(workout.name[0]),
              ),
              title: Text(
                workout.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '${workout.exercises.length} exercises • ${workout.description}',
              ),
              trailing: IconButton(
                icon: const Icon(Icons.play_circle_fill, size: 32),
                color: theme.colorScheme.primary,
                onPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }
}
