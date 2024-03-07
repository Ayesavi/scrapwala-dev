import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class EditAddressTile extends ConsumerWidget {
  final AddressModel model;
  final VoidCallback? onTap;
  const EditAddressTile({super.key, required this.model, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Set the border radius here
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleMedium(
            text: model.label,
          ),
          const SizedBox(
            height: 10,
          ),
          LabelMedium(text: model.address),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
      onTap: onTap,
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const LabelMedium(text: "Phone Number : 7489016865"),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Edit")),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("Delete"))
            ],
          )
        ],
      ),

      leading: switch (model.category) {
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
      },

      // Other relevant details or actions related to the address can be added here
    );
  }
}
