import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:scrapwala_dev/core/utils/utils.dart';
import 'package:scrapwala_dev/features/auth/controllers/auth_controller.dart';
import 'package:scrapwala_dev/gen/assets.gen.dart';
import 'package:scrapwala_dev/widgets/app_filled_button.dart';
import 'package:scrapwala_dev/widgets/logout_popup.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DeletePage extends ConsumerWidget {
  const DeletePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            LottieBuilder.asset(Assets.lottie.sorry),
            const Spacer(),
            const BodyLarge(
                align: TextAlign.center,
                maxLines: 3,
                text:
                    "We are so sorry to see you going, if you are having any problem you can contact our support"),
            const Spacer(),
            OutlinedButton(
                onPressed: () {
                  launchURL('https://www.swachhkabadi.com/help-center');
                },
                child: const Text(
                  "Contact Support",
                )),
            const SizedBox(
              height: 10,
            ),
            AppFilledButton(
              label: 'Delete Account',
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Popup(
                      title: "Delete Account",
                      text: "Are you sure you want to delete account?",
                      onConfirmPopup: () async {
                        await Supabase.instance.client.rpc('delete_user');
                        await ref.read(authControllerProvider).signOut();
                        return;
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
