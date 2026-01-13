import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_palestra/features/auth/domain/repositories/auth_repository.dart';
import 'package:app_palestra/core/constants/supabase_constants.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _supabaseClient;

  AuthRepositoryImpl(this._supabaseClient);

  @override
  Stream<AuthState> get authStateChanges =>
      _supabaseClient.auth.onAuthStateChange;

  @override
  User? get currentUser => _supabaseClient.auth.currentUser;

  @override
  Future<AuthResponse> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<AuthResponse> signUpWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return await _supabaseClient.auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: SupabaseConstants.signUpRedirectUrl,
    );
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }
}
