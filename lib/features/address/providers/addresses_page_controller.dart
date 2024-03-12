import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/core/providers/location_provider/location_controller.dart';
import 'package:scrapwala_dev/features/address/repositories/address_repository.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';

part 'addresses_page_controller.freezed.dart';
part 'addresses_page_controller.g.dart';
part 'addresses_page_controller_state.dart';

@riverpod
class AddressesPageController extends _$AddressesPageController {
  List<AddressModel> _addresses = [];
  final _repo = SupabaseAddressRepository();

  @override
  AddressesPageControllerState build() {
    fetchAddresses();
    return const _Loading();
  }

  void fetchAddresses() async {
    try {
      _addresses = await _repo.getAddresses();
      state = _Data(_addresses);
    } catch (e) {
      state = _Error(e);
    }
  }

  void deleteAddress(BuildContext context, String addressId) async {
    try {
      await _repo.deleteAddress(addressId);
      _addresses.removeWhere((address) => address.id == addressId);
      state = _Data(_addresses);
      ref.invalidate(locationControllerProvider);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, errorHandler(e).message);
      }
    }
  }

  void updateAddress(BuildContext context, AddressModel updatedAddress) async {
    try {
      await _repo.updateAddress(updatedAddress);
      final index =
          _addresses.indexWhere((address) => address.id == updatedAddress.id);
      if (index != -1) {
        _addresses[index] = updatedAddress;
        state = _Data(_addresses);
      }
      ref.invalidate(locationControllerProvider);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, errorHandler(e).message);
      }
    }
  }

  void addAddress(BuildContext context, AddressModel newAddress) async {
    try {
      await _repo.addAddress(newAddress);
      _addresses.add(newAddress);
      state = _Data(_addresses);
      ref.invalidate(locationControllerProvider);
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, errorHandler(e).message);
      }
    }
  }
}
