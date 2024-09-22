import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrapwala_dev/core/remote_config/remote_config_service.dart';
import 'package:scrapwala_dev/core/utils/utils.dart';
import 'package:scrapwala_dev/features/address/controller/select_address_page_controller.dart';
import 'package:scrapwala_dev/features/address/providers/addresses_page_controller.dart';
import 'package:scrapwala_dev/features/address/screens/address_search_page.dart';
import 'package:scrapwala_dev/features/address/widgets/cone_marker.dart';
import 'package:scrapwala_dev/features/address/widgets/on_map_address_widget.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';
import 'package:scrapwala_dev/widgets/location_form_bottomsheet.dart';

/// A widget that allows the user to select an address.
class SelectAddressPage extends ConsumerStatefulWidget {
  /// The edit address model to be displayed initially.
  final AddressModel? addressModel;

  /// A callback function that is called when the user selects an address.
  final void Function(AddressModel addressModel)? onAddressSelected;

  /// Creates a new instance of the SelectAddressPage widget.
  const SelectAddressPage({
    super.key,
    this.addressModel,
    this.onAddressSelected,
  });

  @override
  _SelectAddressPageState createState() => _SelectAddressPageState();
}

/// The state class for the SelectAddressPage widget.
class _SelectAddressPageState extends ConsumerState<SelectAddressPage> {
  /// A text editing controller for the search bar.
  final TextEditingController _searchController = TextEditingController();

  /// A provider for the SelectAddressPageController.
  late final SelectAddressPageControllerProvider provider;

  /// An instance of the AppAnalytics class.
  // final AppAnalytics analytics = AppAnalytics.instance;

  bool isModalShown = false;

  /// Initializes the state of the widget.
  @override
  void initState() {
    super.initState();
    provider = selectAddressPageControllerProvider(context,
        editAddressModel: widget.addressModel);
  }

  /// Builds the user interface for the SelectAddressPage widget.
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(provider);
    final controller = ref.read(provider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(controller),
      body: state.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loadMap: (config) => _buildStack([
          _buildGoogleMap(
            controller: controller,
            initialCameraPosition: config.cameraPosition,
            onMapCreated: controller.onMapCreated,
            onCameraMove: controller.onCameraMove,
            mapStyle: config.style,
            marker: config.marker,
            myLocationEnabled: config.enableLocation,
          ),
        ]),
        error: (e) => Center(child: Text(e.toString())),
        networkError: () => const Center(child: Text('Network error')),
      ),
    );
  }

  /// Builds the Google Map widget.
  Widget _buildGoogleMap({
    String? mapStyle,
    Marker? marker,
    required SelectAddressPageController controller,
    required CameraPosition initialCameraPosition,
    required void Function(GoogleMapController controller) onMapCreated,
    void Function(CameraPosition position)? onCameraMove,
    bool myLocationEnabled = false,
  }) {
    return ValueListenableBuilder(
      valueListenable: controller.markerNotifier,
      builder: (BuildContext context, value, Widget? child) {
        final mapHeight = MediaQuery.sizeOf(context).height;
        final mapWidth = MediaQuery.sizeOf(context).width;

        return Stack(
          alignment: const Alignment(0.0, 0.0),
          children: [
            SizedBox(
              height: mapHeight,
              width: mapWidth,
              child: Stack(
                children: [
                  GoogleMap(
                    onMapCreated: onMapCreated,
                    mapToolbarEnabled: true,
                    onCameraMove: onCameraMove,
                    style: mapStyle,
                    initialCameraPosition: initialCameraPosition,
                    myLocationButtonEnabled: myLocationEnabled,
                    myLocationEnabled: myLocationEnabled,
                  ),
                  Positioned(
                    bottom: 0,
                    child: OnMapAddressWidget(
                      latlng: value ?? initialCameraPosition.target,
                      editAddressModel: widget.addressModel,
                      onTapContinue: (address) {
                        if (_calculateDistance(
                                kCenterLatlng.latitude,
                                kCenterLatlng.longitude,
                                address.latlng.latitude,
                                address.latlng.longitude) <
                            RemoteConfigKeys.maxServiceDistance
                                .value<double>()) {
                          showLocationFormBottomSheet(
                            context: context,
                            title: address.titleAddress,
                            addressModel: widget.addressModel,
                            address: address.formattedAddress,
                            latLng: (
                              lat: value?.latitude ??
                                  initialCameraPosition.target.latitude,
                              lng: value?.longitude ??
                                  initialCameraPosition.target.longitude
                            ),
                            onContinue: (addrModel) async {
                              await saveOrUpdateAddress(
                                updateModel: widget.addressModel,
                                recivedAddressFromForm: addrModel,
                              );
                            },
                          );
                        } else {
                          showLocationAlert(context);
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: (mapHeight - 102) / 2,
              right: (mapWidth - 200) / 2,
              child: const ConeMarker(
                text: "Please the pin accurately to your address",
              ),
            )
          ],
        );
      },
    );
  }

  void showLocationAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Service Unavailable'),
          content: const Text(
            'We do not service this location at the current point of time because we are at an early stage, but keep in touch with us! Right now we service within ambikapur only.',
          ),
          actions: <Widget>[
            OutlinedButton(
                onPressed: () {}, child: const Text("Regions we serve in")),
            FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Okay")),
          ],
        );
      },
    );
  }

  /// Saves or updates the address.
  Future<void> saveOrUpdateAddress({
    AddressModel? updateModel,
    required AddressModel recivedAddressFromForm,
  }) async {
    try {
      if (updateModel != null) {
        await ref
            .read(addressesPageControllerProvider.notifier)
            .updateAddress(context, recivedAddressFromForm);
        if (context.mounted) {
          Navigator.pop(context);
        }
        return;
      }
      await ref
          .read(addressesPageControllerProvider.notifier)
          .addAddress(context, recivedAddressFromForm);
      if (context.mounted) {
        Navigator.pop(context);
      }
      return;
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context,
            'Failed to ${updateModel != null ? 'update' : 'save'} address');
      }
    }
  }

  /// Builds the search bar widget.
  AppBar _buildAppBar(SelectAddressPageController controller) {
    return AppBar(
      title: const Text('Search Address'),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return AddressSearchPage(
                    onLocationSelected: (result, position) {
                      Navigator.pop(context);
                      controller.animateCamera(position);
                      _searchController.text =
                          result.formattedAddress ?? result.name;
                    },
                  );
                },
              ));
            },
            icon: const Icon(Icons.search))
      ],
    );
  }

  /// Builds the stack widget.
  Widget _buildStack(List<Widget> childs) {
    return Stack(
      children: childs,
    );
  }
}

double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371.0; // Earth radius in kilometers
  final double latDistance = _radians(lat2 - lat1);
  final double lonDistance = _radians(lon2 - lon1);
  final double a = pow(sin(latDistance / 2), 2) +
      cos(_radians(lat1)) * cos(_radians(lat2)) * pow(sin(lonDistance / 2), 2);
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
