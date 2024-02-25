import 'package:flutter/material.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/widgets/address_category_chip.dart';
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
    super.key,
    required this.isLocationPermissionGranted,
    required this.onTapLocationPermissionGrant,
    required this.onTapEnterLocationManually,
    required this.addresses,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9, // Cover 90% of the screen height
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on_outlined),
                    SizedBox(width: 10),
                    TitleLarge(
                      text: "Devpuri",
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: LabelMedium(
                    text: "Devpuri Chattisgarh,  4920125, INDIA",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context)
                            .colorScheme
                            .tertiary
                            .withOpacity(0.2),
                      ),
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter house number',
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.home),
                      ),
                    ),
                    const Divider(),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter apartment/road/area',
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.location_city),
                      ),
                    ),
                    const Divider(),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Directions to reach (max 100 chars)',
                        border: InputBorder.none,
                      ),
                      maxLines: 5,
                      maxLength: 100,
                    ),
                    const Text('Save As'),
                    const Wrap(
                      children: [
                        ChipWidget(
                          label: 'Home',
                          isSelected: true,
                          icon: Icons.home,
                        ),
                        ChipWidget(
                          label: 'Work',
                          isSelected: false,
                          icon: Icons.work,
                        ),
                        ChipWidget(
                          label: 'Friend & Family',
                          isSelected: false,
                          icon: Icons.person,
                        ),
                        ChipWidget(
                          label: 'Others',
                          isSelected: false,
                          icon: Icons.category,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
