import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapwala_dev/features/auth/screens/home_screen.dart';
import 'package:scrapwala_dev/features/auth/widgets/text_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(TextThemes.textTheme),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
