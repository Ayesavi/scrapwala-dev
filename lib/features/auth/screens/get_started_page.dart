import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/features/auth/widgets/phone_number_textfield.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/widgets/app_filled_button.dart';
import 'package:scrapwala_dev/widgets/location_bottomsheet.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onTap: () {
                    const LoginRoute().go(context);
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
                  onTap: () {
                    showBottomLocationSheet(context,
                        isDismissable: false,
                        isLocationPermissionGranted: false,
                        addresses: _buildRandomAddressModels());
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

class GetStartedPageConstants {
  static const getStartedPage = "Get Started";
}

List<AddressModel> _buildRandomAddressModels() {
  return [
    AddressModel(
      address: '123 Main Street', 
      landmark: 'Central Park',
      latlng: (lat: 51.5074, lng: 0.1278),
      ownerId: 'user123',
      createdAt: DateTime.now(),
      id: '1',
      category: AddressCategory.friend,
      label: 'Home',
    ),
    AddressModel(
      address: '456 Elm Street',
      latlng: (lat: 51.5074, lng: 0.1278),
      createdAt: DateTime.now(),
      id: '2',
      category: AddressCategory.office,
      label: 'Work',
    ),
    AddressModel(
      address: '789 Oak Street',
      latlng: (lat: 51.5074, lng: 0.1278),
      createdAt: DateTime.now(),
      id: '3',
      category: AddressCategory.house,
      label: 'Vacation Home',
    ),
  ];
}
