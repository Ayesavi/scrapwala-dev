import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/features/auth/widgets/title_medium.dart';

class AppFilledButton extends ConsumerWidget {
  const AppFilledButton(
      {super.key, this.onTap, required this.label, this.bgColor});
  final VoidCallback? onTap;
  final String label;
  final Color? bgColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(
              bgColor ?? Theme.of(context).colorScheme.primary),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(10)),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed)) {
                return Theme.of(context).colorScheme.secondary.withOpacity(
                    .3); // Change overlay color as per your requirement
              }
              return Theme.of(context)
                  .colorScheme
                  .primary; // No overlay color if not pressed
            },
          ),
        ),
        onPressed: onTap,
        child: TitleMedium(
          text: label,
        ),
      ),
    );
  }
}
