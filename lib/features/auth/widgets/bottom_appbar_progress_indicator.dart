import 'package:flutter/material.dart';

class BottomAppBarProgressIndicator extends StatelessWidget
    implements PreferredSizeWidget {
  const BottomAppBarProgressIndicator({super.key});

  @override
  Size get preferredSize =>
      const Size.fromHeight(4.0); // Adjust the height as needed

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(
        Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
