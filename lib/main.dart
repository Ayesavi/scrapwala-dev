import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/app.dart';
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
  runApp(const ProviderScope(child: ScrapWalaApp()));
}