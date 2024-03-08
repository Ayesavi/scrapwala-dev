import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/widgets/edit_address_tile.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class AddressesPage extends ConsumerWidget {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final models = [
      AddressModel(
        address: '123 Main Street',
        landmark: 'Central Park',
        latlng: (lat: 51.5074, lng: 0.1278),
        ownerId: 'user123',
        createdAt: DateTime.now(),
        id: '1',
        category: AddressCategory.friend,
        label: 'Home',
      ),
      AddressModel(
        address: '456 Elm Street',
        latlng: (lat: 51.5074, lng: 0.1278),
        createdAt: DateTime.now(),
        id: '2',
        category: AddressCategory.office,
        label: 'Work',
      ),
      AddressModel(
        address: '789 Oak Street',
        latlng: (lat: 51.5074, lng: 0.1278),
        createdAt: DateTime.now(),
        id: '3',
        category: AddressCategory.house,
        label: 'Vacation Home',
      ),
    ];
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: OutlinedButton(
            style: ButtonStyle(
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            onPressed: () {
              const SelectAddressPageRoute().push(context);
            },
            child: const Text("Add Address")),
      ),
      appBar: AppBar(
        title: const TitleMedium(text: "Manage Addresses"),
      ),
      body: Column(children: [
        Flexible(
          child: ListView.builder(
            itemCount: models.length,
            itemBuilder: (context, index) {
              return EditAddressTile(model: models[index]);
            },
          ),
        ),
      ]),
    );
  }
}
