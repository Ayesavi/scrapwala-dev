import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _progressNotifier = ValueNotifier(false);

showProgress() {
  _progressNotifier.value = true;
}

hideProgress() {
  _progressNotifier.value = false;
}

class ProgressOverlay extends ConsumerWidget {
  final Widget child;

  const ProgressOverlay({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ValueListenableBuilder(
        valueListenable: _progressNotifier,
        builder: (context, activate, prev) {
          return IgnorePointer(
            ignoring: activate,
            child: Stack(
              children: [
                child,
                if (activate)
                  Container(
                    // alignment: Alignment.center,
                    color:
                        Theme.of(context).colorScheme.surface.withOpacity(.4),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).colorScheme.outline),
                      ),
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
