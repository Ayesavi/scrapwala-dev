import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/features/auth/screens/verify_page.dart';
import 'package:scrapwala_dev/features/profile/providers/profile_page_controller.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';
import 'package:scrapwala_dev/widgets/edit_textfield_widget.dart';
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
          child: state.when(loading: () {
            return const SizedBox();
          }, data: (data) {
            final nameController = TextEditingController(text: data.name);
            final phoneNumberController =
                TextEditingController(text: data.phoneNumber?.substring(2));
            final emailAddressController =
                TextEditingController(text: data.email);
            return SingleChildScrollView(
              child: Column(
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
                  EditTextFieldWidget(
                    hintText: "Enter your email address",
                    labelText: "Email Address",
                    textEditingController: emailAddressController,
                    onSave: (email) async {
                      try {
                        controller.upateProfile(email: email);
                      } catch (e) {
                        if (context.mounted) {
                          showSnackBar(context, errorHandler(e).message);
                        }
                      }
                    },
                    validator: validateEmailAddress,
                  ),
                ],
              ),
            );
          })),
    );
  }
}
