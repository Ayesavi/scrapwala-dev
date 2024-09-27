import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/app.dart';
import 'package:scrapwala_dev/core/foundation/log.dart';
import 'package:scrapwala_dev/core/remote_config/remote_config_service.dart';
import 'package:scrapwala_dev/core/services/notification_service.dart';
import 'package:scrapwala_dev/firebase_options.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Supabase.initialize(
      url: const String.fromEnvironment("SUPABASE_URL"),
      anonKey: const String.fromEnvironment("SUPABASE_KEY"));

  RemoteConfigService.initialize();

  runZonedGuarded(() {
    // Pass all uncaught "fatal" errors from the framework to Crashlytics
    FlutterError.onError = Log.recordNonFatalError;
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      Log.recordFatalError(error, stack);
      return true;
    };

    runApp(const ProviderScope(child: ScrapWalaApp()));
  }, (error, stack) {
    Log.recordFatalError(error, stack);
  });
}
