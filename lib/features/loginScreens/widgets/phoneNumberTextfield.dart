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
  TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = false;
  String? phoneNumber;

  @override
  void initState() {
    // TODO: implement initState
    _controller.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 55,
              decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.deepOrange),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
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
                      padding: EdgeInsets.only(left: 2),
                      height: 30,
                      width: 5,
                      child: CustomPaint(
                        foregroundPainter: LinePainter(),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextField(
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
            SizedBox(
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
            SizedBox(
              height: 20,
            ),
            RichText(
                text: TextSpan(
                    style: GoogleFonts.montserrat(
                        fontSize: 15, color: Colors.black),
                    children: [
                  TextSpan(text: "By clicking, I accept the "),
                  TextSpan(
                    text: 'terms of service',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  TextSpan(
                    text: ' and ',
                  ),
                  TextSpan(
                    text: 'privacy policy',
                    style: TextStyle(
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
