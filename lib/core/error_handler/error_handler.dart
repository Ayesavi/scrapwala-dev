import 'dart:io';

import 'package:flutter/services.dart';
import 'package:scrapwala_dev/features/auth/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SkException implements Exception {
  final String message;

  const SkException(this.message);
}

class NetworkException extends SkException {
  NetworkException()
      : super('Please ensure that you are connected to internet');
}

SkException errorHandler(dynamic e) {
  if (e is SkException) {
    return e;
  } else if (e is SocketException) {
    return NetworkException();
  } else if (e is PostgrestException ||
      e is AuthException ||
      e is AuthPKCEGrantCodeExchangeError ||
      e is AuthException ||
      e is TypeError ||
      e is ArgumentError ||
      e is RangeError ||
      e is FormatException ||
      e is UnsupportedError ||
      e is UnAuthenticatedUserException) {
    return SkException(e.toString());
  } else if (e is PlatformException) {
    if (e.code == "network_error") {
      return NetworkException();
    } else {
      return const SkException("An error occurred");
    }
  }
  // Handle other unhandled exceptions here
  return const SkException("An error occurred");
}
