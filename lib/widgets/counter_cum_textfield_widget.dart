import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/utils/debounder.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';

class CounterCumTextFieldWidget extends ConsumerStatefulWidget {
  const CounterCumTextFieldWidget({super.key, required this.onCounterChange});

  final void Function(int qty) onCounterChange;

  @override
  // ignore: library_private_types_in_public_api
  _CounterCumTextFieldWidgetState createState() =>
      _CounterCumTextFieldWidgetState();
}

class _CounterCumTextFieldWidgetState
    extends ConsumerState<CounterCumTextFieldWidget> {
  int _counter = 0;

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
                if (_counter > 0) {
                  _counter--;
                  widget.onCounterChange(_counter);
                } else {
                  _debouncer.call(() {
                    showSnackBar(context, 'Number can not be negative int');
                  });
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
