import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:scrapwala_dev/widgets/location_form_bottomsheet.dart';

class SelectAddressPage extends ConsumerWidget {
  const SelectAddressPage({
    super.key,
  });

  LatLng getRandomLatLng() {
    const lng = 83.18000424131255;
    const lat = 23.148742739195544;

    return const LatLng(lat, lng);
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
          initialPosition: getRandomLatLng(),
          apiKey: const String.fromEnvironment('GOOGLE_MAPS_KEY'),
          onPlacePicked: (pickResult) {
            showLocationFormBottomSheet(
              context,
              pickResult: pickResult,
              onSaveAndProceed: (model) async {
                await Future.delayed(const Duration(seconds: 2), () {
                  return 1;
                });
              },
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
