import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/constants/constants.dart';
import 'package:scrapwala_dev/features/auth/controllers/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

enum NotificationKeys { requests, recommendations }

final notificationServiceProvider = Provider((ref) => NotificationService(ref));

class NotificationService {
  NotificationService(this.ref) {
    _init();
  }

  final ProviderRef ref;
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final SupabaseClient supabase = Supabase.instance.client;
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();
  final prefsFcmKey = "fcm_token";
  String? _token;
  String? userId;
  String? _cachedToken;

  Future<void> _init() async {
    _cachedToken = await getCachedToken();
    _token = await getToken();
    userId = supabase.auth.currentUser?.id;
    final states = ref.watch(authStateChangesProvider);
    states.whenData(_handleAuthStateChanges);
  }

  Future<void> handleLogOut() async {
    await removeToken(_token!);
    prefs.remove(prefsFcmKey);
  }

  void _handleAuthStateChanges(AuthState state) {
    if ([AuthChangeEvent.signedIn, AuthChangeEvent.userUpdated]
        .contains(state.event)) {
      syncToken();
      logger.info("syncing token");
    }
  }

  Future<String?> getToken() async {
    return await firebaseMessaging.getToken();
  }

  void syncToken() {
    final exists = checkIfTokenExists();
    if (!exists) {
      uploadToken();
    } else {
      logger.info("Token exists");
    }
  }

  Future<String?> getCachedToken() async {
    return await prefs.getString(prefsFcmKey);
  }

  void updateTokenInPrefs(String newToken) {
    if (_cachedToken != null) {
      /// token has been updated
      removeToken(_cachedToken!);
      prefs.setString(prefsFcmKey, newToken);
    } else {
      prefs.setString(prefsFcmKey, newToken);
    }
  }

  Future<void> uploadToken() async {
    try {
      if (_token != null && userId != null) {
        await supabase.from("fcm_tokens").insert({
          "token": _token,
        });
        updateTokenInPrefs(_token!);
        logger.log("Token uploaded to Supabase: $_token");
      } else {
        logger.log("user not logged in cant upload fcm token");
      }
    } catch (e) {
      logger.log("Error uploading FCM token: $e");
    }
  }

  Future<void> removeToken(String token) async {
    try {
      if (_token != null && userId != null) {
        await supabase
            .from("fcm_tokens")
            .delete()
            .eq("user_id", userId!)
            .eq("token", token);

        logger.log("Token removed from Supabase: $_token");
      }
    } catch (e) {
      logger.error("Error removing FCM token: $e");
    }
  }

  bool checkIfTokenExists() {
    return _cachedToken == _token;
  }
}
