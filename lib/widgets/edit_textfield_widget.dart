import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditTextFieldWidget extends ConsumerWidget {
  final String hintText;
  final String labelText;
  final TextEditingController textEditingController;
  final TextInputType? type;
  final Future<void> Function(String) onSave;
  final String? Function(String?)? validator;

  EditTextFieldWidget({
    required this.hintText,
    required this.labelText,
    required this.textEditingController,
    this.type,
    required this.onSave,
    this.validator,
    super.key,
  });

  final notifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ValueListenableBuilder(
          valueListenable: notifier,
          builder: (BuildContext context, bool value, Widget? child) {
            return TextField(
              controller: textEditingController,
              keyboardType: type,
              readOnly: !value,
              decoration: InputDecoration(
                hintText: hintText,
                labelText: labelText,
                errorText: validator != null
                    ? validator!(textEditingController.text)
                    : null,
                suffixIcon: TextButton(
                  child: const Text(
                    "Edit",
                  ),
                  onPressed: () {
                    notifier.value = true;
                  },
                ),
              ),
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: notifier,
          builder: (BuildContext context, bool value, Widget? child) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: value
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        key: const ValueKey(true),
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (validator != null &&
                                  validator!(textEditingController.text) !=
                                      null) {
                                return; // Don't save if validation fails
                              }
                              await onSave(textEditingController.text);
                              notifier.value = false;
                            },
                            child: const Text("Save"),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            onPressed: () {
                              notifier.value = false;
                            },
                            child: const Text("Cancel"),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            );
          },
        ),
      ],
    );
  }
}
