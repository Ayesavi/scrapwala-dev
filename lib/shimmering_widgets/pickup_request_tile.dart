import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringPickRequestTile extends StatelessWidget {
  const ShimmeringPickRequestTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color baseColor = theme.colorScheme.onSurface.withOpacity(0.1);
    final Color highlightColor = theme.colorScheme.onSurface.withOpacity(0.05);
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(8.0), // Adjust radius as needed
              child: Container(
                width: 100, // Adjust width according to your UI
                height: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(8.0), // Adjust radius as needed
              child: Container(
                width: 150, // Adjust width according to your UI
                height: 14,
                color: Colors.white,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0), // Adjust radius as needed
            child: Container(
              width: 80, // Adjust width according to your UI
              height: 16,
              color: Colors.white,
            ),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(8.0), // Adjust radius as needed
              child: Container(
                width: 60, // Adjust width according to your UI
                height: 16,
                color: Colors.white,
              ),
            ),
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(8.0), // Adjust radius as needed
              child: Container(
                width: 80, // Adjust width according to your UI
                height: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
