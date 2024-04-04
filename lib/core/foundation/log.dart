import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class Log {
  static void recordFatalError(dynamic error, StackTrace stackTrace) {
    try {
      if (!kDebugMode) {
        FirebaseCrashlytics.instance
            .recordError(error, stackTrace, fatal: true);
      }
    } on Exception {
      //ignore
    }
  }

  static void recordNonFatalError(FlutterErrorDetails error) {
    try {
      if (!kDebugMode) {
        FirebaseCrashlytics.instance.recordFlutterError(error);
      }
    } on Exception {
      //ignore
    }
  }
}
