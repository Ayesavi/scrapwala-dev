import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringAddressTile extends StatelessWidget {
  const ShimmeringAddressTile({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color baseColor = theme.colorScheme.onSurface.withOpacity(0.1);
    final Color highlightColor = theme.colorScheme.onSurface.withOpacity(0.05);
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: ListTile(
        leading: Container(
          width: 56,
          height: 56,
          color: Colors.white,
        ),
        title: Container(
          width: double.infinity,
          height: 16,
          color: Colors.white,
        ),
        subtitle: Container(
          width: double.infinity,
          height: 14,
          color: Colors.white,
        ),
      ),
    );
  }
}
