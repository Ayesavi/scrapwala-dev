import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrapwala_dev/core/constants/theme_constants.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/widgets/app_filled_button.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';
import 'package:uuid/uuid.dart';

class _LocationFormBottomSheet extends StatefulWidget {
  final String? label;
  final String? address;
  final String? houseBlockNumber;
  final ({double lat, double lng}) latLng;
  final String? title;
  final AddressModel? addressModel;
  final Future<void> Function(AddressModel model)? onContinue;

  const _LocationFormBottomSheet({
    // ignore: unused_element
    super.key,
    this.title,
    this.label,
    this.addressModel,
    required this.address,
    this.houseBlockNumber,
    this.onContinue,
    required this.latLng,
  });

  @override
  _FormBottomSheetState createState() => _FormBottomSheetState();
}

class _FormBottomSheetState extends State<_LocationFormBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _addressController;
  late TextEditingController _houseBlockController;
  late TextEditingController _labelController;
  late final bool isEdit;

  AddressModel? getAddressModel() {
    if (_formKey.currentState?.validate() ?? false) {
      return AddressModel(
          id: widget.addressModel?.id ?? const Uuid().v4(),
          address: _addressController.text,
          houseStreetNo: _houseBlockController.text,
          label: _labelController.text,
          latlng: widget.latLng,
          createdAt: DateTime.now(),
          category: AddressCategory.friend);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    isEdit = widget.addressModel != null;
    _addressController = TextEditingController(
        text: widget.address ?? widget.addressModel?.address);
    _houseBlockController = TextEditingController(
        text: widget.addressModel?.houseStreetNo ??
            widget.houseBlockNumber ??
            '');
    _labelController = TextEditingController(
        text: widget.addressModel?.label ?? widget.label ?? '');
  }

  @override
  void dispose() {
    _addressController.dispose();
    _houseBlockController.dispose();
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(CupertinoIcons.location_fill,
                  color: Colors.redAccent),
              title: TitleMedium(
                text: widget.title ?? 'Address',
                weight: FontWeight.bold,
              ),
              subtitle:
                  Text(widget.address ?? widget.addressModel?.address ?? ''),
            ),
            kWidgetVerticalGap,
            BodyMedium(
              text: ' Enter a label *',
              color: Theme.of(context).colorScheme.primary,
              maxLines: 2,
            ),
            kWidgetMinVerticalGap,
            TextFormField(
              controller: _labelController,
              decoration: InputDecoration(
                hintText: 'eg. Home',
                fillColor: Theme.of(context).colorScheme.onInverseSurface,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              validator: (value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Please enter a label';
                }
                return null;
              },
            ),
            kWidgetVerticalGap,
            BodyMedium(
              text: ' Enter the address *',
              color: Theme.of(context).colorScheme.primary,
              maxLines: 2,
            ),
            kWidgetMinVerticalGap,
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                hintText: 'Address',
                fillColor: Theme.of(context).colorScheme.onInverseSurface,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address';
                }
                return null;
              },
            ),
            kWidgetVerticalGap,
            BodyMedium(
              text: ' Enter the house/block number *',
              color: Theme.of(context).colorScheme.primary,
              maxLines: 2,
            ),
            kWidgetMinVerticalGap,
            TextFormField(
              controller: _houseBlockController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.onInverseSurface,
                hintText: 'House/Block Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              validator: (value) {
                if (value?.trim().isEmpty ?? false) {
                  return 'Please enter House / Block number';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            AppFilledButton(
              asyncTap: () async {
                final model = getAddressModel();
                if (model != null) {
                  await widget.onContinue?.call(model);
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                }
              },
              label: ('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

void showLocationFormBottomSheet({
  required BuildContext context,
  String? label,
  String? address,
  String? houseBlockNumber,
  String? title,
  AddressModel? addressModel,
  required latLng,
  Future<void> Function(AddressModel model)? onContinue,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 10,
        ),
        child: _LocationFormBottomSheet(
          label: label, // Optional
          address: address,
          addressModel: addressModel,
          onContinue: onContinue,
          title: title,
          houseBlockNumber: houseBlockNumber, // Optional
          latLng: latLng,
        ),
      );
    },
  );
}
