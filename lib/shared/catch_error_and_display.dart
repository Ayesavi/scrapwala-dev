import 'package:flutter/cupertino.dart';
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';

T? catchErrorShow<T>(BuildContext context, T Function() callback) {
  try {
    return callback();
  } catch (e) {
    if (context.mounted) {
      showSnackBar(context, errorHandler(e).message);
    }
    return null;
  }
}
