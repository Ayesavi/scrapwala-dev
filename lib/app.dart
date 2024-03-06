import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapwala_dev/core/router/router.dart';
import 'package:scrapwala_dev/features/auth/widgets/text_theme.dart';

class ScrapWalaApp extends ConsumerWidget {
  const ScrapWalaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'ScrapWala-Dev',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(TextThemes.textTheme),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.green,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(TextThemes.textTheme),
        colorScheme: ColorScheme.fromSeed(
            primary: Colors.green,
            seedColor: Colors.green,
            brightness: Brightness.dark),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
