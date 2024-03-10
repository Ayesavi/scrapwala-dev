import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/extensions/object_extension.dart';

class ScrapTileImageWidget extends ConsumerWidget {
  const ScrapTileImageWidget(
      {super.key,
      this.imageUrl,
      this.isAdded = false,
      this.onAdd,
      this.onRemove});
  final bool isAdded;
  final String? imageUrl;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addedNotifier =
        ValueNotifier(isAdded); // ValueNotifier to track the button state
    return ValueListenableBuilder<bool>(
      valueListenable: addedNotifier,
      builder: (context, isAdded, _) {
        return Stack(
          children: [
            if (!imageUrl.isNotNull)
              const Icon(Icons.abc)
            else
              Padding(
                padding: ScrapTileImageWidgetConstants.imagePadding,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      ScrapTileImageWidgetConstants.borderRadius),
                  child: SizedBox(
                    height: ScrapTileImageWidgetConstants.imageHeight,
                    width: ScrapTileImageWidgetConstants.imageWidth,
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: ScrapTileImageWidgetConstants.buttonBottomMargin,
              right: ScrapTileImageWidgetConstants.buttonRightMargin,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                    (states) {
                      return isAdded
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.primary;
                    },
                  ),
                  overlayColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Theme.of(context)
                            .colorScheme
                            .secondary
                            .withOpacity(.3);
                      }
                      return isAdded
                          ? Theme.of(context).colorScheme.secondary
                          : Theme.of(context).colorScheme.primary;
                    },
                  ),
                ),
                onPressed: () {
                  if (onAdd != null && !isAdded) {
                    onAdd!();
                    addedNotifier.value = true; // Update the button state
                  } else {
                    onRemove?.call();
                    addedNotifier.value = false; // Update the button state
                  }
                },
                child: Text(
                  isAdded
                      ? ScrapTileImageWidgetConstants.addedButtonText
                      : ScrapTileImageWidgetConstants.addButtonText,
                  style: TextStyle(
                    color: isAdded
                        ? Theme.of(context).colorScheme.onSecondary
                        : Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class ScrapTileImageWidgetConstants {
  static const double borderRadius = 12.0;
  static const double imageHeight = 100.0;
  static const double imageWidth = 100.0;
  static const EdgeInsets imagePadding = EdgeInsets.symmetric(vertical: 25.0);
  static const double buttonBottomMargin = 5.0;
  static const double buttonRightMargin = 5.0;
  static const String addButtonText = 'ADD';
  static const String addedButtonText = 'DROP';
}
