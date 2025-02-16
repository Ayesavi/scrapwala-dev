import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapwala_dev/features/auth/screens/get_started_page.dart';
import 'package:scrapwala_dev/features/auth/screens/login_page.dart';
import 'package:scrapwala_dev/features/auth/widgets/label_text.dart';
import 'package:scrapwala_dev/features/auth/widgets/line_painter.dart';
import 'package:scrapwala_dev/widgets/app_filled_button.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneNumberTextField extends StatefulWidget {
  const PhoneNumberTextField(
      {super.key, required this.onGetOtp, this.onLoginWithGoogle});

  final Function(String? phone) onGetOtp;
  final VoidCallback? onLoginWithGoogle;

  @override
  State<PhoneNumberTextField> createState() => _PhoneNumberTextFieldState();
}

class _PhoneNumberTextFieldState extends State<PhoneNumberTextField> {
  bool _isButtonEnabled = false;
  String? phoneNumber;
  final textController = TextEditingController();
  final smsFill = SmsAutoFill();

  getPhoneNumber() async {
    textController.text = (await smsFill.hint)?.substring(3) ?? '';
    if (textController.text.length == 10) {
      setState(() {
        _isButtonEnabled = true;
      });
    }
  }

  _launchUrl(String uri) async {
    if (!await launchUrl(Uri.parse(uri))) {
      throw Exception('Could not launch url');
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      getPhoneNumber();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 20,
                  ),
                  height: 60,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: PhoneNumberTextFieldConstants.countryCode,
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.outline),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 2),
                          height: 30,
                          width: 5,
                          child: CustomPaint(
                            foregroundPainter: LinePainter(),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextField(
                        controller: textController,
                        style: GoogleFonts.roboto(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(.6),
                            fontSize: 18),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        maxLength: 10,
                        onChanged: (value) {
                          setState(() {
                            _isButtonEnabled = value.length == 10;
                          });
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            counterText: "",
                            border: InputBorder.none,
                            hintText:
                                PhoneNumberTextFieldConstants.mobileNumber,
                            hintStyle: GoogleFonts.roboto(
                                fontSize: 18, color: Colors.grey[800])),
                      ))
                    ],
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    color: Theme.of(context).colorScheme.surface,
                    child: LabelLarge(
                      text: PhoneNumberTextFieldConstants.labelText,
                      style: GoogleFonts.montserrat(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            AppFilledButton(
                bgColor: _isButtonEnabled
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
                label: PhoneNumberTextFieldConstants.getOtp,
                onTap: _isButtonEnabled
                    ? () => widget.onGetOtp('91${textController.text}')
                    : null),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text('Or'),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
            ),
            AppFilledButton(
                bgColor: Theme.of(context).colorScheme.primary,
                label: PhoneNumberTextFieldConstants.loginWithGoogle,
                onTap: widget.onLoginWithGoogle),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text.rich(
                textAlign: TextAlign.center,
                maxLines: 2,
                TextSpan(
                  children: [
                    TextSpan(
                      text: LoginScreenConstants.byClicking,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                        letterSpacing: 0.10,
                      ),
                    ),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () => _launchUrl(
                            'https://www.swachhkabadi.com/terms-of-service'),
                        child: Text(
                          LoginScreenConstants.termsOfService,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    TextSpan(
                      text: LoginScreenConstants.and,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.outline,
                        fontSize: 14,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () =>
                            _launchUrl('https://www.swachhkabadi.com/privacy'),
                        child: Text(
                          LoginScreenConstants.privacyPolicy,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PhoneNumberTextFieldConstants {
  static const loginWithGoogle = "Continue with Google";
  static const countryCode = "+91";
  static const mobileNumber = "10 digit mobile number";
  static const getOtp = "Get OTP";
  static const labelText = "Mobile Number";
  static const accept = "By clicking, I accept the ";
  static const termsOfService = "terms of service";
  static const and = " and ";
  static const privacyPolicy = "privacy policy";
}
