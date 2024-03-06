import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/features/auth/widgets/title_medium.dart';

final progressIndicatorProvider = StateProvider<bool>((ref) => false);

class AppFilledButton extends ConsumerWidget {
  const AppFilledButton({
    super.key,
    required this.label,
    this.bgColor,
    this.onTap,
    this.asyncTap,
  });

  final String label;
  final Color? bgColor;
  final VoidCallback? onTap;
  final Future<void> Function()? asyncTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check if progress is ongoing
    final isProgress = ref.watch(progressIndicatorProvider);
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(
              bgColor ?? Theme.of(context).colorScheme.primary,
            ),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              const EdgeInsets.all(10),
            ),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Theme.of(context)
                      .colorScheme
                      .secondary
                      .withOpacity(.3);
                }
                return null;
              },
            ),
          ),
          onPressed: () async {
            if (onTap != null) {
              onTap!();
            } else if (asyncTap != null && isProgress == false) {
              // Start showing CircularProgressIndicator
              ref
                  .read(progressIndicatorProvider.notifier)
                  .update((state) => true);
              // Call the asyncTap
              asyncTap!().then((value) {
                ref.read(progressIndicatorProvider.notifier).state = false;
              });
              // Stop showing CircularProgressIndicator
            }
          },
          child: isProgress
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TitleMedium(text: label),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: CupertinoActivityIndicator(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ],
                ) // Show progress row if in progress
              : TitleMedium(text: label) // Show label if not in progress

          ),
    );
  }
}
