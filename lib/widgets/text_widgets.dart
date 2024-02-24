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

  const LabelLarge(
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
      overflow: overflow,
      style: style ??
          Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: color, fontWeight: weight),
    );
  }
}

class LabelMedium extends StatelessWidget {
  final String text;
  final TextOverflow overflow;
  final Color? color;
  final FontWeight? weight;

  const LabelMedium(
      {super.key,
      this.weight,
      this.color,
      required this.text,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: Theme.of(context)
          .textTheme
          .labelMedium
          ?.copyWith(color: color, fontWeight: weight),
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

  const TitleMedium(
      {super.key,
      this.style,
      this.color,
      this.weight,
      required this.text,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
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

  const BodyLarge(
      {super.key, required this.text, this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}

class TitleLarge extends StatelessWidget {
  final String text;
  final TextOverflow overflow;

  const TitleLarge(
      {super.key, required this.text, this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

class BodyMedium extends StatelessWidget {
  final String text;
  final TextOverflow overflow;
  final Color? color;
  const BodyMedium(
      {super.key,
      this.color,
      required this.text,
      this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

class HeadlineSmall extends StatelessWidget {
  final String text;
  final TextOverflow overflow;

  const HeadlineSmall(
      {super.key, required this.text, this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}

class TitleSmall extends StatelessWidget {
  final String text;
  final TextOverflow overflow;

  const TitleSmall(
      {super.key, required this.text, this.overflow = TextOverflow.ellipsis});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}
