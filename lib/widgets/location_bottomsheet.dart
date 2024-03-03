import 'package:flutter/material.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/widgets/address_tile.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

void showBottomLocationSheet(
  BuildContext context, {
  required bool isDismissable,
  required bool isLocationPermissionGranted,
  required List<AddressModel> addresses,
}) {
  showModalBottomSheet(
    context: context,
    isDismissible: isDismissable,
    builder: (BuildContext context) {
      return _LocationBottomSheetContent(
        isLocationPermissionGranted: isLocationPermissionGranted,
        addresses: addresses,
        onTapLocationPermissionGrant: () {
          // Handle permission grant action here
        },
        onTapEnterLocationManually: () {
          // Handle entering location manually action here
        },
      );
    },
  );
}

class _LocationBottomSheetContent extends StatelessWidget {
  final bool isLocationPermissionGranted;
  final Function onTapLocationPermissionGrant;
  final Function onTapEnterLocationManually;
  final List<AddressModel> addresses;

  const _LocationBottomSheetContent({
    // ignore: unused_element
    super.key,
    required this.isLocationPermissionGranted,
    required this.onTapLocationPermissionGrant,
    required this.onTapEnterLocationManually,
    required this.addresses,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            tileColor: Theme.of(context).colorScheme.tertiaryContainer,
            subtitle: const LabelMedium(
              text: LocationBottomSheetConstants.locationOfDesc,
              maxLines: 3,
            ),
            title: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 4.0,
              ),
              child: Row(
                children: [
                  Icon(Icons.location_searching_outlined),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TitleMedium(
                      overflow: TextOverflow.ellipsis,
                      text: LocationBottomSheetConstants.locationOffText,
                      weight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            trailing: !isLocationPermissionGranted
                ? ElevatedButton(
                    onPressed: onTapLocationPermissionGrant as void Function()?,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    child: const Text('Grant'),
                  )
                : null,
          ),
          ListTile(
            title: const TitleLarge(
              text: LocationBottomSheetConstants.selectDeliveryAddress,
              weight: FontWeight.bold,
            ),
            trailing: TextButton(
                onPressed: () {},
                child: BodyLarge(
                    color: Theme.of(context).colorScheme.primary,
                    text: 'View All')),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(),
          ),
          if (addresses.isNotEmpty)
            Column(
              children: addresses
                  .map((address) => AddressTile(
                        model: address,
                        isSelected: false,
                        onTap: () {},
                      ))
                  .toList(),
            ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(),
          ),
          ListTile(
            title: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text('Enter Address Manually')
              ],
            ),
            onTap: onTapEnterLocationManually as void Function()?,
          ),
        ],
      ),
    );
  }
}

class LocationBottomSheetConstants {
  static const locationOffText = 'Location Permission is off';

  static const locationOfDesc =
      'Granting location permission will ensure accurate address and hassle free request';
  static const selectDeliveryAddress = 'Select Delivery Address';
}
