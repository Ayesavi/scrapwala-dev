import 'dart:math';

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

  double _calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const R = 6371.0; // Earth radius in kilometers
    final double latDistance = _radians(lat2 - lat1);
    final double lonDistance = _radians(lon2 - lon1);
    final double a = pow(sin(latDistance / 2), 2) +
        cos(_radians(lat1)) *
            cos(_radians(lat2)) *
            pow(sin(lonDistance / 2), 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final double distance = R * c; // Distance in kilometers
    return distance;
  }

  double _radians(double degrees) {
    return degrees * (pi / 180);
  }

  bool _isWithinRadius(
      double lat1, double lon1, double lat2, double lon2, double radius) {
    final double distance = _calculateDistance(lat1, lon1, lat2, lon2);
    return distance <= radius;
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
            if (pickResult.geometry != null) {
              final status = _isWithinRadius(
                  pickResult.geometry!.location.lat,
                  pickResult.geometry!.location.lng,
                  getRandomLatLng().latitude,
                  getRandomLatLng().longitude,
                  35);
              if (status == true) {
                showLocationFormBottomSheet(
                  context,
                  pickResult: pickResult,
                  addressModel: model,
                  onSaveAndProceed: (m) => _onSaveAndProceed(context, m),
                );
              } else {
                _showLocationOutOfReachDialog(context);
              }
            }
          },
          introModalWidgetBuilder: (context, close) {
            return const SizedBox();
          },
        ),
      ),
    );
  }

  void _showLocationOutOfReachDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sorry'),
          content: const Text(
              'Since, We are at the early stage we dont pickup scraps there.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Pop navigator twice to close the dialog and return to the previous screen
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Close the alert dialog
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
