import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/extensions/string_extension.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class EditAddressTile extends ConsumerWidget {
  final AddressModel model;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const EditAddressTile({
    super.key,
    required this.model,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleMedium(
            text: model.label.capitalize,
          ),
          const SizedBox(
            height: 10,
          ),
          LabelMedium(text: '${model.houseStreetNo.capitalize}'),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      onTap: onTap,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelMedium(text: model.address.capitalize),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  shape: WidgetStatePropertyAll<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                onPressed: onEdit,
                child: const Text("Edit"),
              ),
              const SizedBox(
                width: 10,
              ),
              // ElevatedButton(
              //   style: ButtonStyle(
              //     shape: MaterialStateProperty.all<OutlinedBorder>(
              //       RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //     ),
              //   ),
              //   onPressed: onDelete,
              //   child: const Text("Delete"),
              // )
            ],
          )
        ],
      ),
      leading: _buildLeadingIcon(context),
    );
  }

  Widget _buildLeadingIcon(BuildContext context) {
    return switch (model.category) {
      AddressCategory.friend => Icon(
          Icons.group_outlined,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(.6),
        ),
      AddressCategory.house => Icon(
          Icons.home_outlined,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(.6),
        ),
      AddressCategory.office => Icon(
          Icons.maps_home_work_outlined,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(.6),
        ),
      AddressCategory.others => Icon(
          Icons.category,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(.6),
        ),
    };
  }
}
