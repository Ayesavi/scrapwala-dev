import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/widgets/address_category_chip.dart';
import 'package:scrapwala_dev/widgets/app_filled_button.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

void showLocationFormBottomSheet(BuildContext context,
    {required PickResult pickResult,
    AddressModel? addressModel,
    Future<void> Function(AddressModel model)? onSaveAndProceed}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return _LocationFormBottomSheetContent(
        pickResult: pickResult,
        addressModel: addressModel,
        onSaveAndProceed: onSaveAndProceed,
      );
    },
  );
}

class _LocationFormBottomSheetContent extends ConsumerStatefulWidget {
  final Future<void> Function(AddressModel model)? onSaveAndProceed;
  final PickResult pickResult;
  final AddressModel? addressModel;

  const _LocationFormBottomSheetContent({
    required this.pickResult,
    this.addressModel,
    this.onSaveAndProceed,
  });

  @override
  _LocationFormBottomSheetContentState createState() =>
      _LocationFormBottomSheetContentState();
}

class _LocationFormBottomSheetContentState
    extends ConsumerState<_LocationFormBottomSheetContent> {
  final _formKey = GlobalKey<FormState>();
  final houseNumberController = TextEditingController();
  final apartmentController = TextEditingController();
  final directionsController = TextEditingController();
  final labelController = TextEditingController();
  late final ValueNotifier<AddressCategory> saveAsNotifier;

  @override
  void initState() {
    super.initState();

    // Initialize text field controllers with addressModel.label if it exists
    labelController.text = widget.addressModel?.label ?? "";
    houseNumberController.text = widget.addressModel?.houseStreetNo ?? "";
    apartmentController.text =
        widget.addressModel?.apartmentRoadAreadLandmark ?? "";
    saveAsNotifier = ValueNotifier<AddressCategory>(
        widget.addressModel?.category ?? AddressCategory.house);
  }

  AddressModel _formModel() {
    return AddressModel(
      houseStreetNo: houseNumberController.text,
      apartmentRoadAreadLandmark: apartmentController.text,
      address: '${widget.pickResult.formattedAddress}',
      latlng: (
        lat: widget.pickResult.geometry!.location.lat,
        lng: widget.pickResult.geometry!.location.lng,
      ),
      createdAt: DateTime.now(),
      id: widget.addressModel?.id ?? "",
      category: saveAsNotifier.value,
      label: labelController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 10,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on_outlined),
                    const SizedBox(width: 10),
                    TitleLarge(
                      text: widget.pickResult.name ?? "",
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: LabelMedium(
                    maxLines: 2,
                    text: widget.pickResult.formattedAddress ?? "",
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 16.0, left: 16, right: 16),
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
                      child: const Text(
                          'A detailed address will help our delivery partner to reach you accurately.'),
                    ),
                    TextFormField(
                      controller: labelController,
                      decoration: const InputDecoration(
                        hintText: 'Example - Home, Office, Shop',
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.label_outline_rounded),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Label cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const Divider(),
                    TextFormField(
                      controller: houseNumberController,
                      decoration: const InputDecoration(
                        hintText: 'Enter house number',
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.home_outlined),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'House number cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const Divider(),
                    TextFormField(
                      controller: apartmentController,
                      decoration: const InputDecoration(
                        hintText: 'Enter apartment/road/area',
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.location_city_outlined),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Landmark cannot be empty';
                        }
                        return null;
                      },
                    ),
                    const Divider(),
                    TextFormField(
                      controller: directionsController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Directions to reach (max 100 chars)',
                      ),
                      maxLines: 3,
                      maxLength: 100,
                    ),
                    const Divider(),
                    const TitleMedium(text: 'Save As'),
                    const SizedBox(
                      height: 10,
                    ),
                    ValueListenableBuilder(
                      valueListenable: saveAsNotifier,
                      builder: (context, saveAs, _) {
                        return Wrap(
                          spacing: 8,
                          children: [
                            ChipWidget(
                              label: 'Home',
                              isSelected: saveAs == AddressCategory.house,
                              icon: Icons.home,
                              onTap: () {
                                saveAsNotifier.value = AddressCategory.house;
                              },
                            ),
                            ChipWidget(
                              label: 'Work',
                              isSelected: saveAs == AddressCategory.office,
                              icon: Icons.work,
                              onTap: () {
                                saveAsNotifier.value = AddressCategory.office;
                              },
                            ),
                            ChipWidget(
                              label: 'Friend & Family',
                              isSelected: saveAs == AddressCategory.friend,
                              icon: Icons.person,
                              onTap: () {
                                saveAsNotifier.value = AddressCategory.friend;
                              },
                            ),
                            ChipWidget(
                              label: 'Others',
                              isSelected: saveAs == AddressCategory.others,
                              icon: Icons.category,
                              onTap: () {
                                saveAsNotifier.value = AddressCategory.others;
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    AppFilledButton(
                      label: 'Save And Proceed',
                      asyncTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await widget.onSaveAndProceed
                              ?.call(_formModel())
                              .then(
                            (value) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          ).catchError((e) {});
                        }
                      },
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
