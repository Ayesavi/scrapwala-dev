import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringListTile extends StatelessWidget {
  const ShimmeringListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color baseColor = theme.colorScheme.onSurface.withOpacity(0.1);
    final Color highlightColor = theme.colorScheme.onSurface.withOpacity(0.05);
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: ListTile(
        leading: const Icon(
          Icons.check_circle_sharp,
          color: Colors.greenAccent,
        ),
        title: Container(
          width: double.infinity,
          height: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
