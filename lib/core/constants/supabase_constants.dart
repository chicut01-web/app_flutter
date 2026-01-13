import 'package:flutter/foundation.dart' show kIsWeb;

class SupabaseConstants {
  // Supabase project credentials
  static const String url = 'https://exzxnxmrtethtizumpha.supabase.co';
  static const String anonKey =
      'sb_publishable_Fx0nnoF9_tJUZsBZtSzhbQ_ZyASC70z';

  // Vercel deployment URL
  static const String vercelUrl = 'https://app-flutter-pi.vercel.app';

  // Redirect URLs for authentication
  static const String webRedirectUrl = '$vercelUrl/auth/callback';
  static const String mobileRedirectUrl =
      'io.supabase.fluttergym://login-callback/';

  // Get the appropriate redirect URL based on platform
  static String get signUpRedirectUrl =>
      kIsWeb ? webRedirectUrl : mobileRedirectUrl;
}
