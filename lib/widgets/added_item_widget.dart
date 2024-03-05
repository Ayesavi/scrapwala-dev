import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/extensions/string_extension.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/features/auth/widgets/label_text.dart';

/// This widget will be shown at the bottom of the screen
/// whenever any item has been added to the cart see https://github.com/Ayesavi/scrapwala-dev/issues/26)
class AddedItemCartWidget extends ConsumerWidget {
  final int itemAdded;
  const AddedItemCartWidget({super.key, required this.itemAdded});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      width: deviceWidth,
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                title: LabelLarge(
                  text: AddedItemWidgetConstants.itemAddedText
                      .format(positionalArgs: [itemAdded]),
                ),
                trailing: TextButton(
                  onPressed: () {
                    const CartPageRoute().go(context);
                  },
                  child: const Text(
                    AddedItemWidgetConstants.viewCartText,
                  ),
                ),
                tileColor: Theme.of(context).colorScheme.tertiaryContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddedItemWidgetConstants {
  static const itemAddedText = '{} item\'s added';
  static const viewCartText = 'View Request >';
}
