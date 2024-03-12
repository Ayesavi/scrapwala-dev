import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/utils/debounder.dart';

class CounterCumTextFieldWidget extends ConsumerStatefulWidget {
  const CounterCumTextFieldWidget(
      {super.key,
      required this.onCounterChange,
      this.onDecrementItemToZero,
      this.initialValue = 1});
  final int initialValue;
  final VoidCallback? onDecrementItemToZero;
  final void Function(int qty) onCounterChange;

  @override
  // ignore: library_private_types_in_public_api
  _CounterCumTextFieldWidgetState createState() =>
      _CounterCumTextFieldWidgetState();
}

class _CounterCumTextFieldWidgetState
    extends ConsumerState<CounterCumTextFieldWidget> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue;
  }

  final _debouncer = Debouncer(delay: const Duration(milliseconds: 800));

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.remove),
            onPressed: () {
              setState(() {
                if (_counter > 1) {
                  _counter--;
                  widget.onCounterChange(_counter);
                } else {
                  widget.onDecrementItemToZero?.call();
                }
              });
            },
          ),
          Flexible(
            child: TextFormField(
              decoration: const InputDecoration(border: InputBorder.none),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              controller: TextEditingController(text: _counter.toString()),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  setState(() {
                    _counter = int.parse(value);
                  });
                  widget.onCounterChange(_counter);
                }
              },
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                _counter++;
              });
              widget.onCounterChange(_counter);
            },
          ),
        ],
      ),
    );
  }
}
