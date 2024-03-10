import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringContainer extends StatelessWidget {
  const ShimmeringContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color baseColor = theme.colorScheme.onSurface.withOpacity(0.1);
    final Color highlightColor = theme.colorScheme.onSurface.withOpacity(0.05);
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: Theme.of(context).colorScheme.onInverseSurface,
        child: const Text('Scrap Details'),
      ),
    );
  }
}
