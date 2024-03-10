import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringDottedLine extends StatelessWidget {
  const ShimmeringDottedLine({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color baseColor = theme.colorScheme.onSurface.withOpacity(0.1);
    final Color highlightColor = theme.colorScheme.onSurface.withOpacity(0.05);

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 1,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            border: Border.all(
              color: theme.colorScheme.onSurface.withOpacity(0.3),
              width: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
