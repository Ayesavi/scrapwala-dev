import 'package:flutter/material.dart';

class LabelSmall extends StatelessWidget {
  final String text;
  final TextOverflow overflow;

  const LabelSmall(
      {super.key, required this.text, this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: Theme.of(context).textTheme.labelSmall,
    );
  }
}

class LabelLarge extends StatelessWidget {
  final String text;
  final TextOverflow overflow;
  final Color? color;
  final TextStyle? style;
  final FontWeight? weight;
  final int? maxLines;
  final double? spacing;

  const LabelLarge(
      {super.key,
      this.color,
      this.weight,
      this.spacing,
      this.style,
      this.maxLines,
      required this.text,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      style: style ??
          Theme.of(context).textTheme.labelLarge?.copyWith(
              color: color, fontWeight: weight, letterSpacing: spacing),
    );
  }
}

class LabelMedium extends StatelessWidget {
  final String text;
  final TextOverflow overflow;
  final Color? color;
  final TextAlign? align;
  final FontWeight? weight;
  final int? maxLines;
  const LabelMedium(
      {super.key,
      this.weight,
      this.maxLines,
      this.align,
      this.color,
      required this.text,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: align,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: color ??
              Theme.of(context).colorScheme.onBackground.withOpacity(.6),
          fontWeight: weight),
    );
  }
}

class HeadlineLarge extends StatelessWidget {
  final String text;
  final TextOverflow overflow;
  final bool bold;
  final Color? color;
  final FontWeight? weight;

  const HeadlineLarge(
      {super.key,
      this.color,
      this.weight,
      this.bold = false,
      required this.text,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: Theme.of(context)
          .textTheme
          .headlineLarge
          ?.copyWith(fontWeight: weight, color: color),
    );
  }
}

class TitleMedium extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? weight;
  final TextOverflow overflow;
  final TextStyle? style;
  final int? maxLines;
  const TitleMedium(
      {super.key,
      this.style,
      this.color,
      this.maxLines,
      this.weight,
      required this.text,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: style ??
          Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: color, fontWeight: weight),
    );
  }
}

class BodyLarge extends StatelessWidget {
  final String text;
  final TextOverflow overflow;
  final Color? color;
  final FontWeight? weight;
  final int? maxLines;
  final TextAlign? align;

  const BodyLarge(
      {super.key,
      required this.text,
      this.align,
      this.maxLines,
      this.color,
      this.weight,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: align,
      style: Theme.of(context)
          .textTheme
          .bodyLarge
          ?.copyWith(color: color, fontWeight: weight),
    );
  }
}

class TitleLarge extends StatelessWidget {
  final String text;
  final TextOverflow overflow;
  final int? maxLines;
  final FontWeight? weight;
  final Color? color;
  final double? spacing;

  const TitleLarge(
      {super.key,
      required this.text,
      this.weight,
      this.spacing,
      this.maxLines,
      this.color,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: color,
            letterSpacing: spacing,
            fontWeight: weight,
          ),
    );
  }
}

class BodyMedium extends StatelessWidget {
  final String text;
  final TextOverflow overflow;
  final Color? color;
  final int? maxLines;
  const BodyMedium(
      {super.key,
      this.maxLines,
      this.color,
      required this.text,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(

      text,
      maxLines: maxLines,
      overflow: overflow,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

class HeadlineSmall extends StatelessWidget {
  final String text;
  final FontWeight weight;
  final TextOverflow overflow;

  const HeadlineSmall({
    super.key,
    required this.text,
    this.weight = FontWeight.normal,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
        fontWeight: weight,
        fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
        // Add other style properties here if needed
      ),
    );
  }
}

class TitleSmall extends StatelessWidget {
  final String text;
  final TextOverflow overflow;
  final TextStyle? style;
  const TitleSmall(
      {super.key,
      required this.text,
      this.style,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: style ?? Theme.of(context).textTheme.titleSmall,
    );
  }
}
