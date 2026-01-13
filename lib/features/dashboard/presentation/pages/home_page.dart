import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_palestra/features/auth/presentation/providers/auth_provider.dart';
import 'package:app_palestra/features/dashboard/presentation/widgets/summary_card.dart';
import 'package:app_palestra/features/dashboard/presentation/widgets/weekly_progress_chart.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final theme = Theme.of(context);

    // Mock Name if unknown (or use email part)
    final displayName = user?.userMetadata?['full_name'] ?? 'Athlete';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getGreeting(),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        displayName,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    backgroundImage: user?.userMetadata?['avatar_url'] != null
                        ? NetworkImage(user!.userMetadata!['avatar_url'])
                        : null,
                    radius: 24,
                    child: user?.userMetadata?['avatar_url'] == null
                        ? const Icon(Icons.person)
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Stats Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.4,
                children: const [
                  SummaryCard(
                    title: 'Workouts Done',
                    value: '12',
                    icon: Icons.check_circle_outline,
                    color: Colors.blue,
                  ),
                  SummaryCard(
                    title: 'Calories Burned',
                    value: '3,240',
                    icon: Icons.local_fire_department_outlined,
                    color: Colors.orange,
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Activity Chart
              Text(
                'Weekly Activity',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                height: 200,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.cardTheme.color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const WeeklyProgressChart(),
              ),

              const SizedBox(height: 32),

              // Quick Action
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navigate to start workout
                  },
                  icon: const Icon(Icons.play_arrow_rounded),
                  label: const Text('Start New Workout'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
