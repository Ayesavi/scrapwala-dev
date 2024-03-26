import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/features/auth/widgets/phone_number_textfield.dart';
import 'package:scrapwala_dev/widgets/app_filled_button.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

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
                AppFilledButton(
                  label: "Login",
                  onTap: () async {
                    const LoginRoute().push(context);
                  },
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RichText(
                        text: TextSpan(
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(.6)),
                            children: [
                          const TextSpan(
                              text: PhoneNumberTextFieldConstants.accept),
                          TextSpan(
                            text: PhoneNumberTextFieldConstants.termsOfService,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                          const TextSpan(
                            text: PhoneNumberTextFieldConstants.and,
                          ),
                          TextSpan(
                            text: PhoneNumberTextFieldConstants.privacyPolicy,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ]))),
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
