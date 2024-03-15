import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/core/extensions/object_extension.dart';
import 'package:scrapwala_dev/core/providers/location_provider/location_controller.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/features/cart/providers/cart_controller.dart';
import 'package:scrapwala_dev/gen/assets.gen.dart';
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
    final ranges = ['1-10', '10-20', '20-30', '30-40', '40-50', '50+'];
    final qtyRangeNotifier = ValueNotifier<String>('1-10');
    var isCartEmpty = true;
    return Scaffold(
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AppFilledButton(
            label: "Request Pickup",
            asyncTap: () async => onTapRequestPickup(context,
                addressId: addressId,
                ref: ref,
                isCartEmpty: isCartEmpty,
                dateNotifier: dateNotifier,
                qtyNotifier: qtyRangeNotifier,
                controller: controller),
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
                                ...List.generate(ranges.length, (index) {
                                  final range = ranges[index];
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
        final bool isSelectedDayToday = ((selectedDateTime.day == now.day) &&
            (selectedDateTime.month == now.month) &&
            (selectedDateTime.year == selectedDateTime.year));

        if ((!isSelectedDayToday && isTimeInRange(selectedDateTime, 10, 17)) ||
            (isSelectedDayToday &&
                isTimeInRange(selectedDateTime, 10, 14) &&
                selectedDateTime.isAfter(now))) {
          dateNotifier.value = selectedDateTime;
        } else {
          // Inform the user
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Note'),
                  content: Text(
                      'Please select a time between 10 AM to 5 PM on the ${isSelectedDayToday ? 'next' : ""} day.'),
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
  }

  // void showNextDayTimePicker(
  //     BuildContext context, ValueNotifier<DateTime?> dateNotifier) async {
  //   final DateTime nextDay = DateTime.now().add(const Duration(days: 1));
  //   final TimeOfDay? nextDayTime = await showTimePicker(
  //     context: context,
  //     initialTime: const TimeOfDay(hour: 12, minute: 0),
  //   );

  //   if (nextDayTime != null) {
  //     if (nextDayTime.hour >= 17 || nextDayTime.hour <= 10) {
  //       // Show a popup if the selected time is after 5 PM
  //       if (context.mounted) {
  //         showDialog(
  //           context: context,
  //           builder: (BuildContext context) {
  //             return AlertDialog(
  //               title: const Text('Warning'),
  //               content: const Text(
  //                   'Please select a time between 10 AM to 5 PM. We do not operate after 5 PM.'),
  //               actions: <Widget>[
  //                 TextButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop();
  //                     Navigator.of(context).pop();
  //                   },
  //                   child: const Text('OK'),
  //                 ),
  //               ],
  //             );
  //           },
  //         );
  //       }
  //     } else {
  //       dateNotifier.value = DateTime(
  //         nextDay.year,
  //         nextDay.month,
  //         nextDay.day,
  //         nextDayTime.hour,
  //         nextDayTime.minute,
  //       );
  //       if (context.mounted) {
  //         Navigator.of(context).pop();
  //       }
  //     }
  //   }
  // }

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

  void onTapRequestPickup(
    BuildContext context, {
    required String? addressId,
    required WidgetRef ref,
    required bool isCartEmpty,
    required ValueNotifier<DateTime?> dateNotifier,
    required ValueNotifier<String> qtyNotifier,
    required CartController controller,
  }) async {
    try {
      if (addressId.isNotNull && !isCartEmpty && dateNotifier.value.isNotNull) {
        await controller.requestPickUp(
            scheduleDateTime: dateNotifier.value,
            addressId: addressId!,
            qtyRange: qtyNotifier.value);
        ref.invalidate(cartControllerProvider);
        if (context.mounted) {
          showAnimatedCheckMarkPopup(context);
        }
      } else {
        if (isCartEmpty) {
          showSnackBar(context, "Atleast add one scrap to continue");
        } else if (addressId == null) {
          showSnackBar(context, "Please add an address to continue");
        } else if (dateNotifier.value == null) {
          showSnackBar(context, "Please select date and time to continue");
        }
      }
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, errorHandler(e).message);
      }
    }
  }

  bool isTimeInRange(DateTime selectedDateTime, int r1, int r2) {
    return (selectedDateTime.hour >= r1 && selectedDateTime.hour <= r2);
  }

  Future<void> showAnimatedCheckMarkPopup(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                Assets.lottie
                    .checkMark, // Replace with your Lottie animation file
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              const Text('Pickup Requested Successfully!',
                  style: TextStyle(fontSize: 18)),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
