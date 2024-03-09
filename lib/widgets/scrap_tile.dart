import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rich_readmore/rich_readmore.dart';
import 'package:scrapwala_dev/core/constants/string_constants.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';
import 'package:scrapwala_dev/widgets/scrap_tile_image_widget.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class ScrapTile extends ConsumerWidget {
  const ScrapTile(
      {super.key,
      required this.model,
      required this.onTap,
      this.added = false});
  final ScrapModel model;
  final bool added;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleLarge(
            text: model.name,
            weight: FontWeight.bold,
          ),
          const SizedBox(
            height: 10,
          ),
          Text('$kRupeeSymbol ${model.price}')
        ],
      ),
      subtitle: RichReadMoreText.fromString(
        text: model.description,
        textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.6)),
        settings: LineModeSettings(
          trimLines: 2,
          trimCollapsedText: 'Read more',
          trimExpandedText: ' Read Less ',
          onPressReadMore: () {
            /// specific method to be called on press to show more
          },
          onPressReadLess: () {
            /// specific method to be called on press to show less
          },
        ),
      ),
      trailing: ScrapTileImageWidget(
        callback: added ? null : () {},
        imageUrl: model.photoUrl,
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final Widget? leading;
  final Widget title;
  final Widget subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool dense;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;
  final bool enabled;

  const CustomListTile({
    super.key,
    this.leading,
    required this.title,
    this.subtitle = const SizedBox.shrink(),
    this.trailing,
    this.onTap,
    this.dense = false,
    this.contentPadding,
    this.backgroundColor,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // leading ?? const SizedBox(),
              // const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    title,
                    const SizedBox(height: 4),
                    subtitle,
                  ],
                ),
              ),
              const SizedBox(width: 16),
              if (trailing != null) ...[
                trailing!,
              ]
            ],
          ),
        ),
      ),
    );
  }
}
