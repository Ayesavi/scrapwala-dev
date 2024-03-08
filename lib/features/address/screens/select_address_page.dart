import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/core/extensions/object_extension.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';
import 'package:scrapwala_dev/widgets/location_form_bottomsheet.dart';

class SelectAddressPage extends ConsumerWidget {
  final AddressModel? model;
  final void Function(AddressModel model) onAddressSelected;

  const SelectAddressPage(
      {super.key, this.model, required this.onAddressSelected});

  LatLng getRandomLatLng() {
    const lng = 83.18000424131255;
    const lat = 23.148742739195544;
    return const LatLng(lat, lng);
  }

  Future<void> _onSaveAndProceed(
      BuildContext context, AddressModel model) async {
    try {
      await Future.delayed(const Duration(seconds: 2), () {
        return 1;
      });
      if (model.isNotNull) {
        //TODO: Handle New addresss Creation
      } else {
        // TODO: Handle Addresss Updation
      }
      onAddressSelected(model);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, errorHandler(e).message);
      }
    }
  }

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      // appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: PlacePicker(
          initialMapType: MapType.terrain,
          usePlaceDetailSearch: true,
          automaticallyImplyAppBarLeading: false,
          initialPosition: model.isNotNull
              ? LatLng(model!.latlng.lat, model!.latlng.lng)
              : getRandomLatLng(),
          apiKey: const String.fromEnvironment('GOOGLE_MAPS_KEY'),
          onPlacePicked: (pickResult) {
            showLocationFormBottomSheet(
              context,
              pickResult: pickResult,
              addressModel: model,
              onSaveAndProceed: (m) => _onSaveAndProceed(context, m),
            );
          },
          introModalWidgetBuilder: (context, close) {
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
