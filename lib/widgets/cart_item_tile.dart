import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/constants/string_constants.dart';
import 'package:scrapwala_dev/core/utils/debounder.dart';
import 'package:scrapwala_dev/features/cart/providers/cart_controller.dart';
import 'package:scrapwala_dev/models/cart_model/cart_model.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';
import 'package:scrapwala_dev/widgets/counter_cum_textfield_widget.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class CartItemTile extends ConsumerStatefulWidget {
  const CartItemTile({super.key, required this.model, this.onCounterChange});
  final void Function(int qty)? onCounterChange;
  final CartModel model;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartItemTileState();
}

class _CartItemTileState extends ConsumerState<CartItemTile> {
  final _debouncer = Debouncer(delay: const Duration(milliseconds: 800));

  int _counter = 1;
  @override
  Widget build(BuildContext context) {
    final cartController = ref.read(cartControllerProvider.notifier);
    return ListTile(
      title: TitleSmall(
        text: widget.model.scrap.name,
      ),
      subtitle: LabelMedium(text: widget.model.scrap.description),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: 120,
              height: 80,
              child: CounterCumTextFieldWidget(
                initialValue: widget.model.qty,
                onDecrementItemToZero: () {
                  cartController.remooveItemFromCart(widget.model.scrap.id);
                },
                onCounterChange: (int qty) {
                  setState(() {
                    _counter = qty;
                  });
                  _debouncer.call(() {
                    widget.onCounterChange?.call(qty);

                    showSnackBar(context,
                        'Total quantity of ${widget.model.scrap.name} is $_counter ${widget.model.scrap.measure.toName}');
                  });
                },
              )),
          const SizedBox(
            width: 10,
          ),
          Text('$kRupeeSymbol ${widget.model.scrap.price * _counter}'),
        ],
      ),
    );
  }
}
