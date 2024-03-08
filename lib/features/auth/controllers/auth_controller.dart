import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/features/auth/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part "auth_controller.g.dart";

@Riverpod(keepAlive: true)
AuthController authController(AuthControllerRef ref) {
  final authStates = ref.watch(authStateChangesProvider);
  if (authStates.value?.event == null) {
    return const AuthController(AppAuthState.loading);
  }
  if (authStates.value?.session != null) {
    return const AuthController(AppAuthState.authenticated);
  } else {
    return const AuthController(AppAuthState.unauthenticated);
  }
}

@Riverpod(keepAlive: true)
Stream<AuthState> authStateChanges(AuthStateChangesRef ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
}

enum AppAuthState {
  authenticated,
  loading,
  unauthenticated,
}

class AuthController {
  final AppAuthState state;

  const AuthController(this.state);

  AuthRepository get _repo => AuthRepository();

  Future<User?> get user => _repo.getUser();

  Future<void> signInWithOtp(String phone) async {
    await _repo.signInWithOtp(phone);
  }

  Future<void> signOut() async {
    await _repo.signOut();
  }

  Future<User?> signInWithGoogle() async {
    return await _repo.signInWithGoogle();
  }

  Future<User?> verifyOtp(String token,String phone,OtpType type) async {
    return await _repo.verifyOtp(token,phone,type);
  }

  Future<User?> getUser() async {
    return await _repo.getUser();
  }
}
