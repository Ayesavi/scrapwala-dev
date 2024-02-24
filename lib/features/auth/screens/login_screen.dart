import 'package:flutter/material.dart';
import 'package:scrapwala_dev/features/auth/widgets/headline_large.dart';
import 'package:scrapwala_dev/features/auth/widgets/phone_number_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

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
          const Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: HeadlineLarge(
              text: LoginScreenConstants.enterMobileNumberText,
            ),
          ),
          const SizedBox(height: 10),
          Form(
            key: _formKey,
            child: const PhoneNumberTextField(),
          ),
        ],
      ),
    );
  }
}

class LoginScreenConstants {
  static const enterMobileNumberText = "Enter your mobile number to get OTP";
}
