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
import 'package:scrapwala_dev/shared/show_snackbar.dart';
import 'package:scrapwala_dev/widgets/address_category_chip.dart';
import 'package:scrapwala_dev/widgets/app_filled_button.dart';
import 'package:scrapwala_dev/widgets/cart_item_tile.dart';
import 'package:scrapwala_dev/widgets/location_bottomsheet.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? addressId;
    final locationState = ref.watch(locationControllerProvider);
    final locationController = ref.read(locationControllerProvider.notifier);
    final state = ref.watch(cartControllerProvider);
    final controller = ref.watch(cartControllerProvider.notifier);
    final dateNotifier = ValueNotifier<DateTime?>(null);
    final qtyRangeNotifier = ValueNotifier<String>('5-10');
    var isCartEmpty = true;
    return Scaffold(
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppFilledButton(
            label: "Request Pickup",
            asyncTap: () async {
              try {
                if (addressId.isNotNull && !isCartEmpty) {
                  await controller.requestPickUp(
                      scheduleDateTime: dateNotifier.value,
                      addressId: addressId!,
                      qtyRange: '20-30');
                  ref.invalidate(cartControllerProvider);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                } else {
                  if (isCartEmpty) {
                    showSnackBar(context, "Atleast add one scrap to continue");
                  } else {
                    showSnackBar(context, "Please add an address to continue");
                  }
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
                            isCartEmpty = data.isEmpty;
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
                    onTap: () => onTapSheduleTime(context, dateNotifier),
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
                text: '  Select Approx Quantity',
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ValueListenableBuilder(
                          valueListenable: qtyRangeNotifier,
                          builder: (BuildContext context, String value,
                              Widget? child) {
                            return Row(
                              children: [
                                ...List.generate(10, (index) {
                                  final range =
                                      '${(index + 1) * 5}-${(5 + ((index + 1) * 5))}';
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ChipWidget(
                                      label: range,
                                      isSelected: value == range,
                                      onTap: () {
                                        qtyRangeNotifier.value = range;
                                      },
                                    ),
                                  );
                                })
                              ],
                            );
                          },
                        ),
                      ),
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

  void onTapSheduleTime(
      BuildContext context, ValueNotifier<DateTime?> dateNotifier) async {
    // Show date time picker and update the selected date-time
    final DateTime now = DateTime.now();
    final DateTime todayAt2PM = DateTime(now.year, now.month, now.day, 14, 0);

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(now.year + 1),
    );

    if (context.mounted && pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        if (selectedDateTime.isBefore(todayAt2PM)) {
          dateNotifier.value = selectedDateTime;
        } else {
          // Inform the user
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Note'),
                content: const Text(
                    'Please select a time before 2 PM on the next day.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      // Show a popup to select a time before 2 PM on the next day
                      final DateTime nextDay = now.add(const Duration(days: 1));
                      final TimeOfDay? nextDayTime = await showTimePicker(
                        context: context,
                        initialTime: const TimeOfDay(hour: 12, minute: 0),
                      );

                      if (nextDayTime != null) {
                        dateNotifier.value = DateTime(
                          nextDay.year,
                          nextDay.month,
                          nextDay.day,
                          nextDayTime.hour,
                          nextDayTime.minute,
                        );
                      }
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }

  bool isRangeValid(String range) {
    // Split the string by the dash
    List<String> parts = range.split('-');
    // Check if there are exactly two parts
    if (parts.length != 2) {
      return false;
    }
    // Try parsing both parts to integers
    try {
      int.parse(parts[0]);
      int.parse(parts[1]);
      // Check if both integers can be parsed successfully
      return true;
    } catch (e) {
      // Parsing failed, return false
      return false;
    }
  }
}
