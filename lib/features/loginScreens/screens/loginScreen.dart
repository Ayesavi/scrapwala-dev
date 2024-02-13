import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapwala_dev/features/loginScreens/widgets/phoneNumberTextfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          leading: const BackButton(color: Colors.black),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            "Enter your mobile number to get OTP",
            style: GoogleFonts.montserrat(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 25),
          ),
        ),
        const SizedBox(height: 10),
        Form(
          key: _formKey,
          child: PhoneNumberTextField(),
        )
      ],
    ));
  }
}
