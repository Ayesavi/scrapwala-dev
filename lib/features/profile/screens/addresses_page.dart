import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/features/address/providers/addresses_page_controller.dart';
import 'package:scrapwala_dev/features/address/screens/select_address_page.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';
import 'package:scrapwala_dev/shimmering_widgets/shimmering_address_tile.dart';
import 'package:scrapwala_dev/widgets/app_filled_button.dart';
import 'package:scrapwala_dev/widgets/edit_address_tile.dart';
import 'package:scrapwala_dev/widgets/logout_popup.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class AddressesPage extends ConsumerWidget {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addressesPageControllerProvider);
    final controller = ref.read(addressesPageControllerProvider.notifier);
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppFilledButton(
            label: 'Add Address',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return SelectAddressPage(onAddressSelected: (model) {
                    controller.addAddress(context, model);
                  });
                },
              ));
            },
          ),
        ),
        appBar: AppBar(
          title: const TitleMedium(text: "Manage Addresses"),
        ),
        body: state.when(
            loading: () => SingleChildScrollView(
                  child: Column(
                    children: [
                      ...List.generate(
                          12, (index) => const ShimmeringAddressTile())
                    ],
                  ),
                ),
            data: (models) {
              return Stack(
                children: [
                  Column(children: [
                    Flexible(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          controller.fetchAddresses();
                        },
                        child: ListView.builder(
                          itemCount: models.length,
                          itemBuilder: (context, index) {
                            return EditAddressTile(
                                onDelete: () {
                                  showPopup(context, onConfirm: () {
                                    controller.deleteAddress(
                                        context, models[index].id);
                                  });
                                },
                                onEdit: () {
                                  if (!kIsWeb) {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return SelectAddressPage(
                                            model: models[index],
                                            onAddressSelected: (model) async {
                                              controller.updateAddress(
                                                  context, model);
                                            });
                                      },
                                    ));
                                  } else {
                                    showSnackBar(context,
                                        'To edit share, add addresses user our mobile app');
                                  }
                                },
                                model: models[index]);
                          },
                        ),
                      ),
                    ),
                  ]),
                  if (models.isEmpty) ...[
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        "You have no saved addresses yet. To add a new address, simply tap on the \"Add Address\" button below.",
                        // maxLines: 3,
                        textAlign: TextAlign.center,
                      )),
                    )
                  ]
                ],
              );
            },
            error: (error) => const SizedBox()));
  }
}
