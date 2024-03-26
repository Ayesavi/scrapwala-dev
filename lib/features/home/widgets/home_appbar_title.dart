import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/providers/location_provider/location_controller.dart';
import 'package:scrapwala_dev/features/auth/widgets/title_large.dart';
import 'package:scrapwala_dev/widgets/location_bottomsheet.dart';
import 'package:scrapwala_dev/widgets/location_tile_open_bottomsheet.dart';

class HomeAppBarTitle extends ConsumerWidget {
  const HomeAppBarTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationControllerProvider);
    final locationController = ref.read(locationControllerProvider.notifier);
    return locationState.when(
      locationNotSet: () {
        return const LocationTileOpenBottomsheet(model: null);
      },
      empty: () {
        return const TitleLarge(
          text: "ScrapWala Dev",
          weight: FontWeight.bold,
        );
      },
      location: (model) {
        return LocationTileOpenBottomsheet(
          model: model,
          onTap: () {
            showBottomLocationSheet(context, isDismissable: true,
                onTapAddress: (m) {
              locationController.setLocation(m);
              Navigator.pop(context);
            },
                isLocationPermissionGranted: false,
                addresses: locationController.address);
          },
        );
      },
    );
  }
}
