import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:scrapwala_dev/core/constants/string_constants.dart';
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/core/extensions/object_extension.dart';
import 'package:scrapwala_dev/core/providers/location_provider/location_controller.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/features/cart/providers/cart_controller.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/models/cart_model/cart_model.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';
import 'package:scrapwala_dev/widgets/app_filled_button.dart';
import 'package:scrapwala_dev/widgets/cart_item_tile.dart';
import 'package:scrapwala_dev/widgets/location_bottomsheet.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  double totalPrice(List<CartModel> cartItems) {
    double price = 0;
    for (var element in cartItems) {
      price += element.qty * element.scrap.price;
    }
    return price;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? addressId;
    final locationState = ref.watch(locationControllerProvider);
    final locationController = ref.read(locationControllerProvider.notifier);
    final state = ref.watch(cartControllerProvider);
    final controller = ref.watch(cartControllerProvider.notifier);
    final dateNotifier = ValueNotifier<DateTime?>(null);
    return Scaffold(
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppFilledButton(
            label: "Request Pickup",
            asyncTap: () async {
              try {
                if (addressId.isNotNull) {
                  await controller.requestPickUp(
                      scheduleDateTime: dateNotifier.value,
                      addressId: addressId!);
                  ref.invalidate(cartControllerProvider);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                } else {
                  showSnackBar(context, "Please add an address to continue");
                }
              } catch (e) {
                if (context.mounted) {
                  showSnackBar(context, errorHandler(e).message);
                }
              }
            },
          )),
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
              locationState.when(locationNotSet: () {
                return const SizedBox();
              }, empty: () {
                return InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onTap: () {
                    const AddressPageRoute().push(context);
                  },
                  child: Container(
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:
                              Theme.of(context).colorScheme.onInverseSurface),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const LabelLarge(
                            text: "Add a address to continue",
                            weight: FontWeight.bold,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
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
                      )),
                );
              }, location: (model) {
                addressId = model.id;
                return InkWell(
                  onTap: () {
                    showBottomLocationSheet(context, isDismissable: false,
                        onTapAddress: (m) {
                      locationController.setLocation(m);
                      Navigator.pop(context);
                    },
                        isLocationPermissionGranted: false,
                        addresses: locationController.address);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.onInverseSurface),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        model.category.icon(context,
                            color: Theme.of(context).colorScheme.primary),
                        const SizedBox(
                          width: 10,
                        ),
                        TitleMedium(
                          text: model.label,
                          weight: FontWeight.bold,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const TitleMedium(text: '|'),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            model.address,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
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
                );
              }),
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
                      state.when(
                          initial: () => const SizedBox.shrink(),
                          data: (data) {
                            return Column(
                              children: [
                                ...List.generate(
                                    data.length,
                                    (index) => CartItemTile(
                                        onCounterChange: (newQty) {
                                          controller.updateCartQty(
                                              data[index].id, newQty);
                                        },
                                        model: data[index]))
                              ],
                            );
                          }),
                      const Divider(),
                      ListTile(
                        title: const TitleSmall(
                          text: "Add more items",
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon:
                                const Icon(Icons.add_circle_outline_outlined)),
                      )
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              const TitleMedium(
                text: '  Schedule Date And Time',
                weight: FontWeight.bold,
              ),
              // ListTile for scheduling date and time
              const SizedBox(
                height: 10,
              ),
              Container(
                  padding: const EdgeInsets.all(0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Theme.of(context).colorScheme.onInverseSurface),
                  child: ListTile(
                    onTap: () async {
                      // Show date time picker and update the selected date-time
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 1),
                      );
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedDate != null && pickedTime != null) {
                        dateNotifier.value = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                      }
                    },
                    title: ValueListenableBuilder(
                      valueListenable: dateNotifier,
                      builder: (BuildContext context, DateTime? value,
                          Widget? child) {
                        if (value.isNotNull) {
                          return Text(
                              DateFormat('d MMMM h:mm a').format(value!));
                        }
                        return const Text('Select Date & Time');
                      },
                    ),
                    trailing: const Icon(Icons.calendar_today),
                  )),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).colorScheme.onInverseSurface),
              ),
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
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 16, right: 16),
                      title: const TitleSmall(
                        text: 'Item Total',
                      ),
                      trailing: state.when(
                          initial: () =>
                              const TitleMedium(text: "$kRupeeSymbol 0"),
                          data: (data) {
                            return TitleMedium(
                                text: "$kRupeeSymbol${totalPrice(data)}");
                          }),
                    ),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.only(left: 16, right: 16),
                      title: Text(
                        'Service Fee',
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
                      trailing: const TitleMedium(text: "$kRupeeSymbol${15}"),
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
