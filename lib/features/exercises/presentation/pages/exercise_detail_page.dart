import 'package:flutter/material.dart';
import 'package:app_palestra/features/exercises/domain/entities/exercise.dart';

class ExerciseDetailPage extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetailPage({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(exercise.name)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Video Placeholder
            Container(
              height: 250,
              color: Colors.black,
              child: const Center(
                child: Icon(
                  Icons.play_circle_outline,
                  color: Colors.white,
                  size: 64,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Chip(label: Text(exercise.muscleGroup)),
                      const SizedBox(width: 8),
                      Chip(label: Text(exercise.difficulty)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Instructions',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    exercise.description ?? 'No instructions available.',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Equipment',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(exercise.equipment, style: theme.textTheme.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
