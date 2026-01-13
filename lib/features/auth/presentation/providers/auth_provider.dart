import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_palestra/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:app_palestra/features/auth/domain/repositories/auth_repository.dart';

// Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(Supabase.instance.client);
});

// Auth State Stream Provider
final authStateProvider = StreamProvider<AuthState>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
});

// Current User Provider
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.value?.session?.user ??
      Supabase.instance.client.auth.currentUser;
});

// Auth Controller for Actions (Login/Signup)
final authControllerProvider = AsyncNotifierProvider<AuthController, void>(
  AuthController.new,
);

class AuthController extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {
    // no-op
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref
          .read(authRepositoryProvider)
          .signInWithEmailPassword(email: email, password: password),
    );
  }

  Future<void> signUp({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref
          .read(authRepositoryProvider)
          .signUpWithEmailPassword(email: email, password: password),
    );
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).signOut(),
    );
  }
}
