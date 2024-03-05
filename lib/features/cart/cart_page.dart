import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/constants/string_constants.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';
import 'package:scrapwala_dev/widgets/cart_item_tile.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';
import 'package:slider_button/slider_button.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrapModels = [
      const ScrapModel(
          description:
              "Papers used to print photos,Papers used to print photos,Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos",
          price: 23,
          photoUrl: 'https://picsum.photos/100/100?random=9',
          name: "Glossy Papers"),
      const ScrapModel(
          description:
              "Papers used to print photos,Papers used to print photos,Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos, Papers used to print photos",
          price: 23,
          photoUrl: 'https://picsum.photos/100/100?random=9',
          name: "Glossy Papers")
    ];
    final addrModel = AddressModel(
      address: '123 Main Street',
      landmark: 'Central Park',
      latlng: (lat: 51.5074, lng: 0.1278),
      ownerId: 'user123',
      createdAt: DateTime.now(),
      id: '1',
      category: AddressCategory.friend,
      label: 'Home',
    );
    final buttonWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SliderButton(
          alignLabel: Alignment.center,
          width: buttonWidth,
          buttonSize: 60,
          baseColor: Theme.of(context).colorScheme.onPrimary,
          highlightedColor: Theme.of(context).colorScheme.outlineVariant,
          backgroundColor: Theme.of(context).colorScheme.primary,
          action: () async {
            ///Do something here OnSlide
            return false;
          },
          label: Text(
            "Slide to Request Pickup",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 17),
          ),
          icon: Icon(
            Icons.chevron_right,
            size: 50,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      appBar: AppBar(
          title: TitleLarge(
        text: 'Request',
        color: Theme.of(context).colorScheme.onSurface,
      )),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.onInverseSurface),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    addrModel.category.icon(context,
                        color: Theme.of(context).colorScheme.primary),
                    const SizedBox(
                      width: 10,
                    ),
                    TitleMedium(
                      text: addrModel.label,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const TitleMedium(text: '|'),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(addrModel.address),
                    const SizedBox(
                      width: 10,
                    ),
                    Transform.rotate(
                      angle: (90 * (22 / 7)) / 180,
                      child: Icon(
                        Icons.chevron_right_rounded,
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(.6),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.onInverseSurface),
                  child: Column(
                    children: [
                      ...List.generate(scrapModels.length,
                          (index) => CartItemTile(model: scrapModels[index])),
                      const Divider(),
                      ListTile(
                        title: const TitleSmall(
                          text: "Add more items",
                        ),
                        trailing: IconButton(
                            onPressed: () {},
                            icon:
                                const Icon(Icons.add_circle_outline_outlined)),
                      )
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              const TitleMedium(
                text: '  Bill Details',
                weight: FontWeight.bold,
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.onInverseSurface),
                child: Column(
                  children: [
                    const ListTile(
                      contentPadding: EdgeInsets.only(left: 16, right: 16),
                      title: TitleSmall(
                        text: 'Item Total',
                      ),
                      trailing: TitleMedium(text: "$kRupeeSymbol${99}"),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 16, right: 16),
                      title: Text(
                        'Delivery Fee',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.dashed),
                      ),
                      subtitle: const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: LabelMedium(
                            maxLines: 2,
                            text:
                                'Your request will be travelling long enough to get your order.'),
                      ),
                      trailing: const TitleMedium(text: "$kRupeeSymbol${99}"),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
