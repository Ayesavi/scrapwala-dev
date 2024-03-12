import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class EditAddressTileShimmer extends StatelessWidget {
  final ThemeData theme;

  const EditAddressTileShimmer({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    final Color baseColor = theme.colorScheme.onSurface.withOpacity(0.1);
    final Color highlightColor = theme.colorScheme.onSurface.withOpacity(0.05);

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: ListTile(
          title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 20,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  height: 20,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          onTap: () {},
          subtitle: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 20,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 40,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    Container(
                      width: 80,
                      height: 40,
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          ),
          leading: _buildLeadingIcon(context),
        ),
      ),
    );
  }

  Widget _buildLeadingIcon(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.onBackground.withOpacity(0.6),
      ),
      child: const Icon(
        Icons.category,
        color: Colors.white,
      ),
    );
  }
}
