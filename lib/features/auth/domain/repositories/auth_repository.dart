import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Stream<AuthState> get authStateChanges;
  User? get currentUser;
  Future<AuthResponse> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<AuthResponse> signUpWithEmailPassword({
    required String email,
    required String password,
  });
  Future<void> signOut();
}
