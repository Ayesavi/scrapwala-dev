import 'package:flutter/material.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class ChipWidget extends StatelessWidget {
  final String label;
  final bool isSelected;
  final IconData icon;

  const ChipWidget({
    super.key,
    required this.label,
    required this.isSelected,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        label: LabelLarge(
          text: label,
          color:
              isSelected ? Theme.of(context).colorScheme.primary : Colors.black,
        ),
        side: BorderSide(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.white30,
            width: 1.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        avatar: Icon(
          icon,
          color:
              isSelected ? Theme.of(context).colorScheme.primary : Colors.black,
        ),
        backgroundColor: isSelected
            ? Theme.of(context).colorScheme.primary.withOpacity(.2)
            : Colors.grey[100]);
  }
}
