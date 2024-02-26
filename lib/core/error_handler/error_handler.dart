import 'dart:io';

import 'package:flutter/services.dart';
import 'package:scrapwala_dev/features/auth/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SkException implements Exception {
  final String message;

  const SkException(this.message);
}

SkException errorHandler(dynamic e) {
  if (e is SkException) {
    return e;
  } else if (e is SocketException) {
    return const SkException("Can't connect to the internet");
  } else if (e is PostgrestException ||
      e is AuthException ||
      e is AuthPKCEGrantCodeExchangeError) {
    return SkException(e.message);
  } else if (e is AuthException) {
    return SkException(e.message);
  } else if (e is TypeError) {
    return const SkException("Type error occurred");
  } else if (e is ArgumentError) {
    return SkException("Argument error: ${e.message}");
  } else if (e is RangeError) {
    return SkException("Range error : ${e.message}");
  } else if (e is FormatException) {
    return SkException("Format error : ${e.message}");
  } else if (e is UnsupportedError) {
    return SkException("Unsupported error : ${e.message}");
  } else if (e is UnAuthenticatedUserException) {
    return SkException(e.toString());
  } else if (e is PlatformException) {
    if (e.code == "network_error") {
      return const SkException(
          "Please ensure that you are connected to internet");
    }
    return const SkException("An error occurred");
  } else {
    return const SkException("An error occurred");
  }
}
