import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/widgets/edit_textfield_widget.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class EditProfilePage extends ConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = TextEditingController();
    final phoneNumberController = TextEditingController();
    final emailAddressController = TextEditingController();

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            EditTextFieldWidget(
              hintText: "Enter your name",
              labelText: "Name",
              textEditingController: nameController,
              onSave: (name) async {},
              validator: validateName,
            ),
            const SizedBox(height: 8),
            EditTextFieldWidget(
              hintText: "Enter your phone number",
              labelText: "Phone Number",
              type: TextInputType.phone,
              textEditingController: phoneNumberController,
              onSave: (phone) async {
                 
              },
              validator: validatePhoneNumber,
            ),
            EditTextFieldWidget(
              hintText: "Enter your email address",
              labelText: "Email Address",
              textEditingController: emailAddressController,
              onSave: (email) async {},
              validator: validateEmailAddress,
            ),
          ],
        ),
      ),
    );
  }
}
