import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/constants/string_constants.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';
import 'package:scrapwala_dev/widgets/counter_cum_textfield_widget.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class CartItemTile extends ConsumerStatefulWidget {
  const CartItemTile({super.key, required this.model});

  final ScrapModel model;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CartItemTileState();
}

class _CartItemTileState extends ConsumerState<CartItemTile> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TitleSmall(
        text: widget.model.name,
      ),
      subtitle: LabelMedium(text: widget.model.description),
      trailing: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
              width: 120,
              height: 80,
              child: CounterCumTextFieldWidget(
                onCounterChange: (int qty) {
                  setState(() {
                    _counter = qty;
                  });
                },
              )),
          const SizedBox(
            width: 10,
          ),
          Text('$kRupeeSymbol ${widget.model.price * _counter}')
        ],
      ),
    );
  }
}
