import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/core/extensions/object_extension.dart';
import 'package:scrapwala_dev/core/remote_config/remote_config_service.dart';
import 'package:scrapwala_dev/features/auth/controllers/auth_controller.dart';
import 'package:scrapwala_dev/features/auth/screens/verify_page.dart';
import 'package:scrapwala_dev/features/profile/providers/profile_page_controller.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';
import 'package:scrapwala_dev/shimmering_widgets/shimmer_edit_textfield.dart';
import 'package:scrapwala_dev/widgets/app_filled_button.dart';
import 'package:scrapwala_dev/widgets/edit_textfield_widget.dart';
import 'package:scrapwala_dev/widgets/logout_popup.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profilePageControllerProvider);
    final controller = ref.read(profilePageControllerProvider.notifier);

    // Validator functions using regex
    String? validateName(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your name';
      }
      return null;
    }

    String? validatePhoneNumber(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your phone number';
      }
      final phoneRegExp = RegExp(r'^\d{10}$'); // 10 digit phone number
      if (!phoneRegExp.hasMatch(value)) {
        return 'Please enter a valid phone number';
      }
      return null;
    }

    String? validateEmailAddress(String? value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your email address';
      }
      final emailRegExp = RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); // Simple email regex pattern
      if (!emailRegExp.hasMatch(value)) {
        return 'Please enter a valid email address';
      }
      return null;
    }

    return Scaffold(
      appBar: AppBar(
        title: const TitleMedium(
          text: "Edit Profile",
          weight: FontWeight.bold,
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: state.when(error: (e) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TitleMedium(
                      maxLines: 2,
                      text: 'Looks like there is an error from our side'),
                  const SizedBox(
                    height: 20,
                  ),
                  AppFilledButton(
                    label: "Logout",
                    onTap: () {
                      ref.read(authControllerProvider).signOut();
                    },
                  ),
                ],
              ),
            );
          }, loading: () {
            return const ShimmeringTextField();
          }, data: (data) {
            final nameController = TextEditingController(text: data.name);
            final phoneNumberController = TextEditingController(
                text: data.phoneNumber.isNotNull && data.phoneNumber!.isNotEmpty
                    ? data.phoneNumber!.substring(2)
                    : '');
            final emailAddressController =
                TextEditingController(text: data.email);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                EditTextFieldWidget(
                  hintText: "Enter your name",
                  labelText: "Name",
                  textEditingController: nameController,
                  onSave: (name) async {
                    try {
                      controller.upateProfile(name: name);
                    } catch (e) {
                      if (context.mounted) {
                        showSnackBar(context, errorHandler(e).message);
                      }
                    }
                  },
                  validator: validateName,
                ),
                const SizedBox(height: 8),
                if (RemoteConfigKeys.enablePhoneAuth.value<bool>()) ...[
                  EditTextFieldWidget(
                    hintText: "Enter your phone number",
                    labelText: "Phone Number",
                    type: TextInputType.phone,
                    textEditingController: phoneNumberController,
                    onSave: (phone) async {
                      try {
                        await controller.upateProfile(phone: '91$phone');
                        if (context.mounted) {
                          showSnackBar(context, "Otp Sent to +91$phone");
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return OtpVerifyPage(
                                phoneNum: '91$phone',
                                otpType: OtpType.phoneChange,
                              );
                            },
                          ));
                        }
                      } catch (e) {
                        if (context.mounted) {
                          showSnackBar(context, errorHandler(e).message);
                        }
                      }
                    },
                    validator: validatePhoneNumber,
                  ),
                ],
                EditTextFieldWidget(
                  hintText: "Enter your email address",
                  labelText: "Email Address",
                  textEditingController: emailAddressController,
                  onSave: (email) async {
                    try {
                      controller.upateProfile(email: email);

                      if (context.mounted) {
                        showSnackBar(context, "Otp Sent to $email");
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return OtpVerifyPage(
                              email: email,
                              otpType: OtpType.email,
                            );
                          },
                        ));
                      }
                    } catch (e) {
                      if (context.mounted) {
                        showSnackBar(context, errorHandler(e).message);
                      }
                    }

                    try {} catch (e) {
                      if (context.mounted) {
                        showSnackBar(context, errorHandler(e).message);
                      }
                    }
                  },
                  validator: validateEmailAddress,
                ),
                if (ref.read(authControllerProvider).state ==
                    AppAuthState.unfulfilledProfile) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextButton(
                          child: const Text('Logout'),
                          onPressed: () {
                            showLogOutPopup(
                              context,
                              onConfirm: () {
                                ref.read(authControllerProvider).signOut();
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ]
              ],
            );
          })),
    );
  }
}
