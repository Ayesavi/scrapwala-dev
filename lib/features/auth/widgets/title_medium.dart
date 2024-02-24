import 'package:flutter/material.dart';
import 'package:scrapwala_dev/features/auth/widgets/text_theme.dart';

class TitleMedium extends StatelessWidget {
  final String text;
  final TextOverflow overflow;
  final Color? color;
  final TextStyle? style;
  final FontWeight? weight;

  const TitleMedium(
      {super.key,
      this.color,
      this.weight,
      this.style,
      required this.text,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          TextThemes.textThemes.titleMedium
              ?.copyWith(color: color ?? Colors.white, fontWeight: weight),
    );
  }
}
