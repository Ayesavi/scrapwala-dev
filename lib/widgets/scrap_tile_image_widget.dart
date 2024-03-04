import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/extensions/object_extension.dart';

class ScrapTileImageWidget extends ConsumerWidget {
  const ScrapTileImageWidget({super.key, this.callback, this.imageUrl});

  final String? imageUrl;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                return callback != null
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary;
              },
            ), overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Theme.of(context).colorScheme.secondary.withOpacity(
                      .3); // Change overlay color as per your requirement
                }
                return Theme.of(context)
                    .colorScheme
                    .primary; // No overlay color if not pressed
              },
            )),
            onPressed: callback,
            child: Text(ScrapTileImageWidgetConstants.addButtonText,
                style: TextStyle(
                    color: callback.isNotNull
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSecondary)),
          ),
        )
      ],
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
  static const String addedButtonText = 'ADDED!';
}
