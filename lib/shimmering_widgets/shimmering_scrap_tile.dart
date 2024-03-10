import 'package:flutter/material.dart';
import 'package:scrapwala_dev/widgets/scrap_tile.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringScrapTile extends StatelessWidget {
  const ShimmeringScrapTile({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color baseColor = theme.colorScheme.onSurface.withOpacity(0.1);
    final Color highlightColor = theme.colorScheme.onSurface.withOpacity(0.05);
    return CustomListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              width: 200, // Adjust the width as needed
              height: 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 100, // Adjust the width as needed
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: baseColor,
              ),
            ),
          ),
        ],
      ),
      subtitle: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: baseColor,
          ),
          width: double.infinity,
          height: 20, // Adjust the height as needed
        ),
      ),
      trailing: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 80, // Adjust the width as needed
          height: 80, // Adjust the height as needed
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: baseColor,
          ),
        ),
      ),
    );
  }
}
