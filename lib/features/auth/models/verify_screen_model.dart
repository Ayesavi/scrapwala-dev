import 'package:flutter/material.dart';

class VerifyScreenModel extends ChangeNotifier {
  String _otp = '';

  String get otp => _otp;

  void setOtp(String value) {
    _otp = value;
    notifyListeners();
  }

  bool get isButtonEnabled => _otp.length == 6;
}
