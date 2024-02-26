// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart' as p;
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/features/auth/controllers/auth_controller.dart';
import 'package:scrapwala_dev/features/auth/models/verify_screen_model.dart';
import 'package:scrapwala_dev/features/auth/widgets/bottom_appbar_progress_indicator.dart';
import 'package:scrapwala_dev/features/auth/widgets/headline_large.dart';
import 'package:scrapwala_dev/features/auth/widgets/title_medium.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';

final showProgress = StateProvider((ref) => false);

class OtpVerifyPage extends StatelessWidget {
  final String? phoneNum;

  const OtpVerifyPage({super.key, this.phoneNum});

  @override
  Widget build(BuildContext context) {
    return p.ChangeNotifierProvider(
      create: (_) => OtpVerifyPageModel(),
      child: _OtpVerifyPageContent(phoneNum: phoneNum),
    );
  }
}

class _OtpVerifyPageContent extends ConsumerWidget {
  final String? phoneNum;

  final textController = TextEditingController();

  _OtpVerifyPageContent({
    super.key,
    this.phoneNum,
  });

  onVerify(BuildContext context, AuthController controller,
      OtpVerifyPageModel model, WidgetRef ref) async {
    try {
      ref.read(showProgress.notifier).update((state) => true);

      await controller.verifyOtp(model.otp, phoneNum!);
      ref.read(showProgress.notifier).update((state) => false);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, errorHandler(e).message);
      }
      textController.clear();
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
          bottom: isProgress ? const BottomAppBarProgressIndicator() : null,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                leading: const BackButton(color: Colors.black),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: HeadlineLarge(text: OtpVerifyPagesConstants.verifyOtp),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: p.Consumer<OtpVerifyPageModel>(
                  builder: (context, model, _) => Pinput(
                    controller: textController,
                    length: 6,
                    onChanged: (s) {
                      model.setOtp(s);

                      if (s.length == 6) {
                        onVerify(context, controller, model,ref);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: p.Consumer<OtpVerifyPageModel>(
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
                      onPressed: model.isButtonEnabled
                          ? () => onVerify(context, controller, model,ref)
                          : null,
                      child: const TitleMedium(
                        text: OtpVerifyPagesConstants.continueText,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OtpVerifyPagesConstants {
  static const verifyOtp = "Verify with OTP sent to ";
  static const continueText = "Continue";
}
