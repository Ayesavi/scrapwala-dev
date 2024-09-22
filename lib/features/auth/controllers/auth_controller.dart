import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/core/remote_config/remote_config_service.dart';
import 'package:scrapwala_dev/core/services/notification_service.dart';
import 'package:scrapwala_dev/core/utils/utils.dart';
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
    final sessionUser = authStates.value!.session!.user;
    final userMetadata = sessionUser.userMetadata;
    final phone = sessionUser.phone;
    final name = userMetadata?.containsKey("full_name") ?? false
        ? userMetadata!['full_name']
        : null;

    final isPhoneAuthEnabled = RemoteConfigKeys.enablePhoneAuth.value<bool>();

    // TODO: add the email and phone in the fields below in prod mode
    if (checkNullOrEmpty([
      name,
      ...(isPhoneAuthEnabled ? [phone] : [])
    ])) {
      return const AuthController(AppAuthState.unfulfilledProfile);
    }

    SupabaseNotificationWrapper.instance.initialize();

    FirebaseAnalytics.instance.setUserId(
      id: sessionUser.id,
    );

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

  /// When user is authenticated but profile details are not filled
  /// which is required
  unfulfilledProfile
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

  Future<User?> verifyOtp(
      {required String token,
      String? phone,
      required OtpType type,
      String? email}) async {
    return await _repo.verifyOtp(
        t: token, phoneNumber: phone, email: email, otpType: type);
  }

  Future<User?> getUser() async {
    return await _repo.getUser();
  }
}
