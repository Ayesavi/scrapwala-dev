import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:scrapwala_dev/features/auth/models/verify_screen_model.dart';
import 'package:scrapwala_dev/features/auth/widgets/headline_large.dart';
import 'package:scrapwala_dev/features/auth/widgets/title_medium.dart';

class VerifyScreen extends StatelessWidget {
  final String? phoneNum;

  const VerifyScreen({Key? key, this.phoneNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VerifyScreenModel(),
      child: _VerifyScreenContent(phoneNum: phoneNum),
    );
  }
}

class _VerifyScreenContent extends StatelessWidget {
  final String? phoneNum;

  const _VerifyScreenContent({Key? key, this.phoneNum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              leading: const BackButton(color: Colors.black),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: HeadlineLarge(text: VerifyScreensConstants.verifyOtp),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Consumer<VerifyScreenModel>(
                builder: (context, model, _) => Pinput(
                  length: 6,
                  onChanged: model.setOtp,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: Consumer<VerifyScreenModel>(
                  builder: (context, model, _) => TextButton(
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.deepOrange.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: model.isButtonEnabled
                          ? Colors.deepOrange
                          : Colors.deepOrange.shade300,
                    ),
                    onPressed: model.isButtonEnabled ? () {} : null,
                    child: const TitleMedium(
                      text: VerifyScreensConstants.continueText,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VerifyScreensConstants {
  static const verifyOtp = "Verify with OTP sent to ";
  static const continueText = "Continue";
}
