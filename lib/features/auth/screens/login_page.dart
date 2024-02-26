import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/features/auth/controllers/auth_controller.dart';
import 'package:scrapwala_dev/features/auth/widgets/bottom_appbar_progress_indicator.dart';
import 'package:scrapwala_dev/features/auth/widgets/headline_large.dart';
import 'package:scrapwala_dev/features/auth/widgets/phone_number_textfield.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';

final showProgress = StateProvider((ref) => false);



class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final GlobalKey _formKey = GlobalKey<FormState>();

  onSignInWithGoogle(context, AuthController controller, WidgetRef ref) async {
    try {
      ref.read(showProgress.notifier).update((state) => true);

      await controller.signInWithGoogle();
      ref.read(showProgress.notifier).update((state) => false);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, errorHandler(e).message);
      }
      ref.read(showProgress.notifier).update((state) => false);
    }
  }

  onSignUp(BuildContext context, AuthController controller, WidgetRef ref,
      String phoneNumber) async {
    try {
      ref.read(showProgress.notifier).update((state) => true);
      await controller.signInWithOtp(phoneNumber);
      ref.read(showProgress.notifier).update((state) => false);
      if (context.mounted) {
        OtpPageRoute(phoneNumber).go(context);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, errorHandler(e).message);
      }
      ref.read(showProgress.notifier).update((state) => false);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(authControllerProvider);
    final isProgress = ref.watch(showProgress);
    return IgnorePointer(
      ignoring: isProgress,
      child: Scaffold(
        appBar: AppBar(
            bottom: isProgress ? const BottomAppBarProgressIndicator() : null),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: HeadlineLarge(
                text: LoginScreenConstants.enterMobileNumberText,
              ),
            ),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: PhoneNumberTextField(
                onLoginWithGoogle: () =>
                    onSignInWithGoogle(context, controller, ref),
                onGetOtp: (phoneNumber) {
                  if (phoneNumber != null) {
                    onSignUp(context, controller, ref, phoneNumber);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreenConstants {
  static const enterMobileNumberText = "Enter your mobile number to get OTP";
}
