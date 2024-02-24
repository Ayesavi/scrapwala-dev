import 'package:flutter/material.dart';
import 'package:scrapwala_dev/features/auth/screens/login_screen.dart';
import 'package:scrapwala_dev/features/auth/widgets/title_medium.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: Colors.white,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.deepOrange,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            child: const TitleMedium(
              text: HomeScreenConstants.getStarted,
            )),
      ),
    );
  }
}

class HomeScreenConstants {
  static const getStarted = "Get Started";
}
