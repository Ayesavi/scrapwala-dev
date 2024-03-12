import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/core/extensions/object_extension.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';

enum _AddedNotifierValue { added, removed, progress }

class ScrapTileImageWidget extends ConsumerWidget {
  const ScrapTileImageWidget(
      {super.key,
      this.imageUrl,
      this.isAdded = false,
      this.onAdd,
      this.onRemove});
  final bool isAdded;

  final String? imageUrl;
  final Future<void> Function()? onAdd;
  final Future<void> Function()? onRemove;

  Widget getChild(BuildContext context, _AddedNotifierValue value) {
    return switch (value) {
      _AddedNotifierValue.progress => const CupertinoActivityIndicator(),
      _AddedNotifierValue.added => Text(
          ScrapTileImageWidgetConstants.addedButtonText,
          style: TextStyle(color: Theme.of(context).colorScheme.onSecondary)),
      _AddedNotifierValue.removed =>
        Text(ScrapTileImageWidgetConstants.addButtonText,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
            )),
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addedNotifier = ValueNotifier(isAdded
        ? _AddedNotifierValue.added
        : _AddedNotifierValue
            .removed); // ValueNotifier to track the button state
    return ValueListenableBuilder<_AddedNotifierValue>(
      valueListenable: addedNotifier,
      builder: (context, value, _) {
        final isAdded = value == _AddedNotifierValue.added;
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
                onPressed: () async {
                  if (onAdd != null && !isAdded) {
                    addedNotifier.value =
                        _AddedNotifierValue.progress; // Update the button state
                    try {
                      await onAdd?.call();
                      addedNotifier.value = _AddedNotifierValue.added;
                    } catch (e) {
                      addedNotifier.value = _AddedNotifierValue.removed;
                      if (context.mounted) {
                        showSnackBar(context, errorHandler(e).message);
                      }
                    } // Update the button state
                  } else {
                    addedNotifier.value =
                        _AddedNotifierValue.progress; // Update the button state
                    try {
                      await onRemove?.call();
                      addedNotifier.value = _AddedNotifierValue.removed;
                    } catch (e) {
                      addedNotifier.value = _AddedNotifierValue.added;
                      if (context.mounted) {
                        showSnackBar(context, errorHandler(e).message);
                      }
                    } // Update the button state
                  }
                },
                child: getChild(context, value),
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
