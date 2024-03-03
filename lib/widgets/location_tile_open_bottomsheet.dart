import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/extensions/object_extension.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class LocationTileOpenBottomsheet extends ConsumerWidget {
  const LocationTileOpenBottomsheet(
      {super.key, required this.model, this.onTap});

  final AddressModel? model;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: onTap,
      title: Row(children: [
        if (!model.isNotNull)
          Icon(Icons.share_location_outlined,
              color: Theme.of(context).colorScheme.primary)
        else
          model!.category
              .icon(context, color: Theme.of(context).colorScheme.primary),
        const SizedBox(
          width: 10,
        ),
        TitleMedium(
          text: !model.isNotNull ? "Loading..." : model!.label,
          weight: FontWeight.bold,
        ),
        const SizedBox(
          width: 5,
        ),
        Transform.rotate(
          angle: (90 * (22 / 7)) / 180,
          child: Icon(
            Icons.chevron_right_rounded,
            color: Theme.of(context).colorScheme.onBackground.withOpacity(.6),
          ),
        )
      ]),
      subtitle: model.isNotNull
          ? LabelMedium(
              text: model!.address,
              maxLines: 1,
            )
          : null,
    );
  }
}
