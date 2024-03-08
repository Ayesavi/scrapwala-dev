import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringEditAddressTile extends StatelessWidget {
  const ShimmeringEditAddressTile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildShimmeringTitle(theme),
          const SizedBox(
            height: 10,
          ),
          _buildShimmeringLabel(theme),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildShimmeringButton(theme),
              const SizedBox(
                width: 10,
              ),
              _buildShimmeringButton(theme),
            ],
          )
        ],
      ),
      leading: _buildShimmeringIcon(theme),
    );
  }

  Widget _buildShimmeringTitle(ThemeData theme) {
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.onInverseSurface,
      highlightColor: theme.colorScheme.onInverseSurface.withOpacity(0.5),
      child: Container(
        width: 150,
        height: 20,
        color: theme.colorScheme.onInverseSurface,
      ),
    );
  }

  Widget _buildShimmeringLabel(ThemeData theme) {
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.onSurface,
      highlightColor: theme.colorScheme.onSurface.withOpacity(0.5),
      child: Container(
        width: double.infinity,
        height: 16,
        color: Colors.white,
      ),
    );
  }

  Widget _buildShimmeringButton(ThemeData theme) {
    return Expanded(
      child: SizedBox(
        height: 36,
        child: Shimmer.fromColors(
          baseColor: theme.colorScheme.onSurface,
          highlightColor: theme.colorScheme.onSurface.withOpacity(0.5),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmeringIcon(ThemeData theme) {
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.onSurface,
      highlightColor: theme.colorScheme.onSurface.withOpacity(0.5),
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }
}
