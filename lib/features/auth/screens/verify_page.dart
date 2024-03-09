// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart' as p;
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/features/auth/controllers/auth_controller.dart';
import 'package:scrapwala_dev/features/auth/models/verify_screen_model.dart';
import 'package:scrapwala_dev/features/auth/widgets/bottom_appbar_progress_indicator.dart';
import 'package:scrapwala_dev/features/auth/widgets/headline_large.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';
import 'package:scrapwala_dev/widgets/app_filled_button.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final showProgress = StateProvider((ref) => false);

class OtpVerifyPage extends StatelessWidget {
  final String? phoneNum;
  final OtpType otpType;
  final String? email;
  const OtpVerifyPage(
      {super.key, this.email, this.phoneNum, this.otpType = OtpType.sms});

  @override
  Widget build(BuildContext context) {
    return p.ChangeNotifierProvider(
      create: (_) => OtpVerifyPageModel(),
      child: OtpVerifyContent(
        phoneNum: phoneNum,
        otpType: otpType,
        email: email,
      ),
    );
  }
}

class OtpVerifyContent extends ConsumerStatefulWidget {
  const OtpVerifyContent(
      {super.key, this.phoneNum, this.email, required this.otpType});
  final String? phoneNum;
  final String? email;
  final OtpType otpType;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OtpVerifyContentState();
}

class _OtpVerifyContentState extends ConsumerState<OtpVerifyContent> {
  final smsFill = SmsAutoFill();

  @override
  void initState() {
    smsFill.code.listen((otp) {
      textController.text = otp;
    });
    super.initState();
  }

  final textController = TextEditingController();

  onVerify(BuildContext context, AuthController controller,
      OtpVerifyPageModel model, WidgetRef ref) async {
    try {
      ref.read(showProgress.notifier).update((state) => true);

      await controller.verifyOtp(
          token: model.otp,
          phone: widget.phoneNum,
          email: widget.email,
          type: widget.otpType);
      ref.read(showProgress.notifier).update((state) => false);
      if (widget.otpType != OtpType.sms && context.mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, errorHandler(e).message);
      }
      textController.clear();
      ref.read(showProgress.notifier).update((state) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        onVerify(context, controller, model, ref);
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
                    builder: (context, model, _) => AppFilledButton(
                        bgColor: model.isButtonEnabled
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                        label: OtpVerifyPagesConstants.continueText,
                        onTap: model.isButtonEnabled
                            ? () => onVerify(context, controller, model, ref)
                            : null),
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
