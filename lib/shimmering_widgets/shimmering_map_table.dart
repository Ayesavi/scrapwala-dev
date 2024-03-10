import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmeringMapTableWidget extends StatelessWidget {
  const ShimmeringMapTableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Color baseColor = theme.colorScheme.onSurface.withOpacity(0.1);
    final Color highlightColor = theme.colorScheme.onSurface.withOpacity(0.05);
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: SingleChildScrollView(
        child: Table(
          border: TableBorder.all(
            color: Theme.of(context).colorScheme.outline,
            borderRadius: BorderRadius.circular(12),
          ),
          columnWidths: const {
            0: FractionColumnWidth(0.4),
            1: FractionColumnWidth(0.3),
            2: FractionColumnWidth(0.3),
          },
          children: [
            for (int i = 0; i < 5; i++)
              const TableRow(
                children: [
                  ShimmeringTableCell(),
                  ShimmeringTableCell(),
                  ShimmeringTableCell(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class ShimmeringTableCell extends StatelessWidget {
  const ShimmeringTableCell({super.key});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
