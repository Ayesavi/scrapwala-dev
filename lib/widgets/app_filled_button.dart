import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/features/auth/widgets/title_medium.dart';

class AppFilledButton extends ConsumerWidget {
  const AppFilledButton({super.key, this.onTap, required this.label});
  final VoidCallback? onTap;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(10),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          onPressed: onTap,
          child: TitleMedium(
            text: label,
          )),
    );
  }
}
