import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scrapwala_dev/core/extensions/object_extension.dart';

class SearchTextField extends StatefulWidget {
  final List<String> hintTexts;
  final bool readOnly;
  final VoidCallback? onPressed;
  final TextEditingController? textController;
  final bool triggerSearchOnChange;
  final void Function(String key)? onSearch;
  const SearchTextField({
    super.key,
    this.hintTexts = const [
      'Laptop',
      'Stabliser',
      'Computer',
      'Iron',
      'Weight Blocks'
    ],
    this.readOnly = false,
    this.onPressed,
    this.onSearch,
    this.triggerSearchOnChange = false,
    this.textController,
  });

  @override
  _SearchTextFieldState createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late int _hintIndex;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _hintIndex = 0;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _controller.reverse().then((_) {
        setState(() {
          _hintIndex = (_hintIndex + 1) % widget.hintTexts.length;
        });
        _controller.forward();
      });
    });
    if (widget.textController.isNotNull && widget.triggerSearchOnChange) {
      widget.textController!.addListener(() {
        widget.onSearch?.call(widget.textController!.text);
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onInverseSurface,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onSubmitted: (value) {
                widget.onSearch?.call(value);
              },
              keyboardType: TextInputType.text,
              controller: widget.textController,
              readOnly: widget.readOnly,
              onTap: widget.onPressed,
              decoration: InputDecoration(
                hintText: "Try search for '${widget.hintTexts[_hintIndex]}'",
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w100,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: widget.onPressed,
            icon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}
