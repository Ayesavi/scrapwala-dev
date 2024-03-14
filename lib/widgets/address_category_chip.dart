import 'package:flutter/material.dart';
import 'package:scrapwala_dev/core/extensions/object_extension.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class ChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final IconData? icon;
  final VoidCallback? onTap;

  const ChipWidget({
    super.key,
    required this.label,
    this.onTap,
    required this.isSelected,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Chip(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        label: LabelLarge(
          text: label,
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurface,
        ),
        side: BorderSide(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.white30,
          width: 1.2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        avatar: icon.isNotNull
            ? Icon(
                icon,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.onSurface,
              )
            : null,
      ),
    );
  }
}
