import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/constants/string_constants.dart';
import 'package:scrapwala_dev/models/cart_model/cart_model.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class CartItemTile extends ConsumerStatefulWidget {
  const CartItemTile({super.key, required this.model, this.onCounterChange});
  final void Function(int qty)? onCounterChange;
  final CartModel model;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartItemTileState();
}

class _CartItemTileState extends ConsumerState<CartItemTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TitleSmall(
        text: widget.model.scrap.name,
      ),
      subtitle: LabelMedium(text: widget.model.scrap.description),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              LabelLarge(text: '$kRupeeSymbol ${widget.model.scrap.price}'),
              Text(' /${widget.model.scrap.measure.name}'),
            ],
          ),
        ],
      ),
    );
  }
}
