import 'package:flutter/material.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

showLogOutPopup(BuildContext context, {required VoidCallback onConfirm}) async {
  return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return LogoutPopup(
        onConfirmLogout: () {
          onConfirm();
        },
      );
    },
  );
}

class LogoutPopup extends StatelessWidget {
  final Function()? onConfirmLogout;

  const LogoutPopup({super.key, this.onConfirmLogout});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const TitleLarge(
        text: 'Logout',
        weight: FontWeight.bold,
      ),
      content: const Text('Are you sure you want to logout from this device?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Call the onConfirmLogout callback if provided
            if (onConfirmLogout != null) {
              onConfirmLogout!();
            }
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Logout'),
        ),
      ],
    );
  }
}
