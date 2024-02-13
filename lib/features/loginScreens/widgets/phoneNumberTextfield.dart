import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrapwala_dev/features/loginScreens/screens/verifyScreen.dart';
import 'package:scrapwala_dev/features/loginScreens/widgets/linePainter.dart';

class PhoneNumberTextField extends StatefulWidget {
  const PhoneNumberTextField({super.key});

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
                            hintText: "+91",
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
                            hintText: "10 digit mobile number",
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
                    child: Text(
                      'Mobile Number',
                      style: GoogleFonts.montserrat(
                          color: Colors.deepOrange,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
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
                      ? () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VerifyScreen(
                                        phoneNum: phoneNumber,
                                      )));
                        }
                      : null,
                  child: Text(
                    "Get OTP",
                    style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
                text: TextSpan(
                    style: GoogleFonts.montserrat(
                        fontSize: 15, color: Colors.black),
                    children: [
                  const TextSpan(text: "By clicking, I accept the "),
                  TextSpan(
                    text: 'terms of service',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  const TextSpan(
                    text: ' and ',
                  ),
                  TextSpan(
                    text: 'privacy policy',
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
