import 'package:flutter/material.dart';
import 'package:flutter_google_maps_webservices/places.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/core/utils/debouncer.dart';
import 'package:scrapwala_dev/features/address/repositories/places_repository.dart';

part 'address_search_controller.freezed.dart';
part 'address_search_controller.g.dart';
part 'address_search_controller_state.dart';

@riverpod
class AddressSearchController extends _$AddressSearchController {
  late BasePlacesRepository _repo;

  final debouncer = Debouncer(delay: const Duration(milliseconds: 800));

  final TextEditingController controller = TextEditingController();

  @override
  AddressSearchControllerState build() {
    _repo = ref.watch(placesRepositoryProvider);
    return const AddressSearchControllerState.initial();
  }

  void searchPlaces(String search) async {
    try {
      state = const AddressSearchControllerState.loading();
      final data = await _repo.getPlacesByText(search);
      state = AddressSearchControllerState.data(data);
    } catch (e) {
      if (e == NetworkException) {
        state = const AddressSearchControllerState.networkError();
      }
      state = AddressSearchControllerState.error(errorHandler(e));
    }
  }
}
