import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_palestra/features/auth/presentation/providers/auth_provider.dart';
import 'package:app_palestra/features/auth/presentation/pages/login_page.dart';
import 'package:app_palestra/features/auth/presentation/pages/sign_up_page.dart';
import 'package:app_palestra/features/dashboard/presentation/pages/home_page.dart';
import 'package:app_palestra/features/dashboard/presentation/pages/scaffold_with_nav_bar.dart';
import 'package:app_palestra/features/exercises/presentation/pages/exercises_page.dart';
import 'package:app_palestra/features/workouts/presentation/pages/workouts_page.dart';
import 'package:app_palestra/features/settings/presentation/pages/profile_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  // Use a ValueNotifier to trigger refreshes when auth state changes
  final refreshNotifier = ValueNotifier<int>(0);
  ref.listen(authStateProvider, (previous, next) {
    refreshNotifier.value++;
  });

  // Define helper for redirection
  final isLoggedIn = authState.value?.session != null;

  return GoRouter(
    initialLocation: '/',
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final path = state.uri.toString();
      final isLoggingIn = path == '/login';
      final isSigningUp = path == '/signup';
      final isAuthCallback = path.startsWith('/auth/callback');

      if (!isLoggedIn && !isLoggingIn && !isSigningUp && !isAuthCallback) {
        return '/login';
      }

      if (isLoggedIn && (isLoggingIn || isSigningUp)) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
      GoRoute(path: '/signup', builder: (context, state) => const SignUpPage()),
      // Auth callback route for email confirmation redirects
      GoRoute(
        path: '/auth/callback',
        builder: (context, state) {
          // This route handles the redirect from Supabase after email confirmation
          // The auth state listener will automatically redirect to home if authenticated
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/', builder: (context, state) => const HomePage()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/exercises',
                builder: (context, state) => const ExercisesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/workouts',
                builder: (context, state) => const WorkoutsPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
