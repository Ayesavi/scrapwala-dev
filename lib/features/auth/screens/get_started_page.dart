import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:scrapwala_dev/core/remote_config/remote_config_service.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/features/auth/controllers/auth_controller.dart';
import 'package:scrapwala_dev/features/auth/screens/login_page.dart';
import 'package:scrapwala_dev/features/auth/widgets/phone_number_textfield.dart';
import 'package:scrapwala_dev/widgets/app_filled_button.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final analytics = FirebaseAnalytics.instance;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Lottie.asset(
                    'assets/lottie/recycle.json',
                  ),
                ),
                const ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: TitleLarge(
                    text: 'ACCOUNT',
                  ),
                  subtitle: LabelMedium(
                      text: 'Login/Create Account to manage requests'),
                ),
                Consumer(
                  builder: (context, ref, child) {
                    final isPhoneAuthEnabled =
                        RemoteConfigKeys.enablePhoneAuth.value<bool>();

                    RemoteConfigKeys.enablePhoneAuth.subscribeWithinWidget(ref);

                    return AppFilledButton(
                      label:
                          isPhoneAuthEnabled ? "Login" : "Continue with google",
                      onTap: () async {
                        if (isPhoneAuthEnabled) {
                          const LoginRoute().push(context);
                        } else {
                          ref.read(authControllerProvider).signInWithGoogle();
                        }
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: LoginScreenConstants.byClicking,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                            letterSpacing: 0.10,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () => _launchURL(
                                'https://www.swachhkabadi.com/terms-of-service'),
                            child: Text(
                              LoginScreenConstants.termsOfService,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        TextSpan(
                          text: LoginScreenConstants.and,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.outline,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        WidgetSpan(
                          child: GestureDetector(
                            onTap: () => _launchURL(
                                'https://www.swachhkabadi.com/privacy'),
                            child: Text(
                              LoginScreenConstants.privacyPolicy,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                ListTile(
                  onTap: () async {
                    _launchUrl();
                    await analytics
                        .logEvent(name: 'see_scrap_rates', parameters: {});
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: Icon(
                    Icons.mail_outline,
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.6),
                  ),
                  title: const BodyLarge(
                    weight: FontWeight.w300,
                    text: 'See Scrap Rates',
                  ),
                  trailing: Icon(Icons.chevron_right_outlined,
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(.6)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_launchUrl() async {
  if (!await launchUrl(Uri.parse(GetStartedPageConstants.scrapPriceUri))) {
    throw Exception('Could not launch url');
  }
}

class GetStartedPageConstants {
  static const getStartedPage = "Get Started";
  static const scrapPriceUri = 'https://www.swachhkabadi.com/scrap-rates';
}
