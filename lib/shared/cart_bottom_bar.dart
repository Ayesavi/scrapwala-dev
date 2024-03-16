import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/features/cart/providers/cart_controller.dart';
import 'package:scrapwala_dev/widgets/added_item_widget.dart';
import 'package:scrapwala_dev/widgets/requess_status_combined_widget.dart';

class CartBottomBar extends ConsumerWidget {
  const CartBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartState = ref.watch(cartControllerProvider);
    return cartState.when(
        initial: () => const SizedBox.shrink(),
        data: (data) {
          if (data.isNotEmpty) {
            return AddedItemCartWidget(
              itemAdded: data.length,
            );
          }
          return const SizedBox.shrink();
        });
  }
}
