import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapwala_dev/features/auth/widgets/Label_text.dart';
import 'package:scrapwala_dev/features/auth/widgets/line_painter.dart';
import 'package:scrapwala_dev/features/auth/widgets/title_medium.dart';

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
                      border: Border.all(width: 2, color: Colors.deepOrange),
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
                                fontSize: 18, color: Colors.grey[800]),
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
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontSize: 18),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        maxLength: 10,
                        onChanged: (value) {
                          setState(() {
                            _isButtonEnabled = value.length == 10;
                            phoneNumber = value;
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
                    color: Colors.white,
                    child: LabelLarge(
                      text: PhoneNumberTextFieldConstants.labelText,
                      style: GoogleFonts.montserrat(
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
                width: double.infinity,
                height: 60,
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.deepOrange.shade300,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: _isButtonEnabled
                          ? Colors.deepOrange
                          : Colors.deepOrange.shade300),
                  onPressed: _isButtonEnabled
                      ? () => widget.onGetOtp('91$phoneNumber')
                      : null,
                  child: const TitleMedium(
                    text: PhoneNumberTextFieldConstants.getOtp,
                  ),
                )),
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
            SizedBox(
                width: double.infinity,
                height: 60,
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.deepOrange.shade300,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.deepOrange),
                  onPressed: widget.onLoginWithGoogle,
                  child: const TitleMedium(
                    text: PhoneNumberTextFieldConstants.loginWithGoogle,
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            RichText(
                text: TextSpan(
                    style: GoogleFonts.montserrat(
                        fontSize: 15, color: Colors.black),
                    children: [
                  const TextSpan(text: PhoneNumberTextFieldConstants.accept),
                  TextSpan(
                    text: PhoneNumberTextFieldConstants.termsOfService,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  const TextSpan(
                    text: PhoneNumberTextFieldConstants.and,
                  ),
                  TextSpan(
                    text: PhoneNumberTextFieldConstants.privacyPolicy,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ]))
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
