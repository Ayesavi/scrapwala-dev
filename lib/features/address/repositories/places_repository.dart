import 'dart:math';

import 'package:flutter_google_maps_webservices/geocoding.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/features/address/repositories/ambikapur_places.dart';

final placesRepositoryProvider = Provider<BasePlacesRepository>((ref) {
  return GooglePlacesRepository();
});

abstract class BasePlacesRepository {
  Future<List<PlacesSearchResult>> getPlacesByText(String searchText);
  Future<List<GeocodingResult>> getPlaceAddressFromLatLng(LatLng latLng);
  Future<LatLng> getCurrentLocation();
}

// Fake implementation
class FakePlacesRepository implements BasePlacesRepository {
  final list = <PlacesSearchResult>[];

  FakePlacesRepository() {
    _generateList();
  }

  _generateList() {
    ambikapurPlaces.forEach((key, map) {
      list.add(PlacesSearchResult(
          name: key,
          reference: 'https',
          placeId: '',
          formattedAddress: map['formattedAddress'] as String,
          geometry: Geometry(
              location: Location(
            lat: (map['latlng'] as dynamic)['latitude'] as double,
            lng: (map['latlng'] as dynamic)['longitude'] as double,
          ))));
    });
  }

  @override
  Future<List<PlacesSearchResult>> getPlacesByText(String searchText) async {
    // In a real implementation, you'd probably use an API or database to fetch places,
    // but for this example, we'll just return some hard-coded data.
    return await Future.delayed(const Duration(milliseconds: 500), () {
      final data = list.where((e) {
        if (e.name.toLowerCase().contains(searchText) ||
            (e.formattedAddress?.toLowerCase().contains(searchText) ?? false)) {
          return true;
        }
        return false;
      });
      return data.toList();
    });
  }

  @override
  Future<List<GeocodingResult>> getPlaceAddressFromLatLng(LatLng latLng) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      GeocodingResult(
        geometry: Geometry(location: Location(lat: 2.00, lng: 4.00)),
        placeId: 'xSDF0-WM',
        formattedAddress: list[Random().nextInt(list.length)].formattedAddress,
      ),
      GeocodingResult(
        geometry: Geometry(location: Location(lat: 2.00, lng: 4.00)),
        placeId: 'xSDF0-WM',
        formattedAddress: list[Random().nextInt(list.length)].formattedAddress,
      ),
      GeocodingResult(
        geometry: Geometry(location: Location(lat: 2.00, lng: 4.00)),
        placeId: 'xSDF0-WM',
        formattedAddress: list[Random().nextInt(list.length)].formattedAddress,
      )
    ];
  }

  @override
  Future<LatLng> getCurrentLocation() async {
    // Returning a hardcoded Position object for testing purposes
    return const LatLng(21.1458, 79.0882);
  }
}

class GooglePlacesRepository implements BasePlacesRepository {
  final GoogleMapsPlaces places =
      GoogleMapsPlaces(apiKey: const String.fromEnvironment("GOOGLE_MAPS_KEY"));

  final GoogleMapsGeocoding geolocation = GoogleMapsGeocoding(
      apiKey: const String.fromEnvironment("GOOGLE_MAPS_KEY"));
  @override
  Future<List<PlacesSearchResult>> getPlacesByText(String searchText) async {
    final response = await places.searchByText(searchText);
    if (response.hasNoResults) {
      return [];
    }
    if (response.isInvalid || response.isDenied) {
      throw const SkException('Invalid Search result');
    }
    return (response.results);
  }

  @override
  Future<List<GeocodingResult>> getPlaceAddressFromLatLng(LatLng latLng) async {
    final response = (await geolocation.searchByLocation(
        Location(lat: latLng.latitude, lng: latLng.longitude)));

    if (response.hasNoResults) {
      return [];
    }
    if (response.isInvalid || response.isDenied) {
      throw const SkException('Invalid Search result');
    }
    return (response.results);
  }

  @override
  Future<LatLng> getCurrentLocation() async {
    bool serviceEnabled;
    // Check if location services are enabled

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, don't continue
      return Future.error('Location services are disabled.');
    }

    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  }
}
