import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:scrapwala_dev/core/constants/string_constants.dart';
import 'package:scrapwala_dev/core/extensions/string_extension.dart';
import 'package:scrapwala_dev/models/pickup_request_model/pickup_request_model.dart';
import 'package:scrapwala_dev/widgets/request_status_widget.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class PickRequestTile extends ConsumerWidget {
  const PickRequestTile({super.key, required this.onTap, required this.model});
  final PickupRequestModel model;
  final void Function(PickupRequestModel model) onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      onTap: () => onTap.call(model),
      title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        TitleSmall(
          text: '#${model.id}',
        ),
        const SizedBox(height: 5),
        LabelMedium(text: 'Civil Lines'.capitalize)
      ]),
      subtitle: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: LabelLarge(
          text: "$kRupeeSymbol ${model.qtyRange} >",
          color: Theme.of(context).colorScheme.onBackground.withOpacity(.6),
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          RequestStatusWidget(model.status),
          Text(DateFormat('d MMMM yyyy', 'en_US')
              .format(model.requestDateTime.toLocal())),
        ],
      ),
    );
  }
}
