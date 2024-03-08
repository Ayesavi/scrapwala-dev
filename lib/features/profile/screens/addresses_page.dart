import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/features/address/screens/select_address_page.dart';
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
        latlng: (lat: 21.194271664973005, lng: 81.64625836387516),
        ownerId: 'user123',
        createdAt: DateTime.now(),
        id: '1',
        houseStreetNo: '57',
        category: AddressCategory.friend,
        label: 'Home',
      ),
      AddressModel(
        address: '456 Elm Street',
        houseStreetNo: '57',
        latlng: (lat: 21.199327432464067, lng: 81.63295087726094),
        createdAt: DateTime.now(),
        id: '2',
        category: AddressCategory.office,
        label: 'Work',
      ),
      AddressModel(
        houseStreetNo: '57',
        address: '789 Oak Street',
        latlng: (lat: 21.167664260103805, lng: 81.59443543357389),
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
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return SelectAddressPage(onAddressSelected: (model) {});
                },
              ));
            },
            child: const Text("Add Address")),
      ),
      appBar: AppBar(
        title: const TitleMedium(text: "Manage Addresses"),
      ),
      body: Column(children: [
        Flexible(
          child: RefreshIndicator(
            onRefresh: () async {},
            child: ListView.builder(
              itemCount: models.length,
              itemBuilder: (context, index) {
                return EditAddressTile(
                    onDelete: () {},
                    onEdit: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SelectAddressPage(
                              model: models[index],
                              onAddressSelected: (model) {});
                        },
                      ));
                    },
                    model: models[index]);
              },
            ),
          ),
        ),
      ]),
    );
  }
}
