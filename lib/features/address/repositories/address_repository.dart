import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseAddressRepository {
  // Create operation
  Future<void> addAddress(AddressModel address);

  // Read operation
  Future<List<AddressModel>> getAddresses();

  // Update operation
  Future<void> updateAddress(AddressModel address);

  // Delete operation
  Future<void> deleteAddress(String addressId);
}

class SupabaseAddressRepository implements BaseAddressRepository {
  final _supabaseClient = Supabase.instance.client;

  @override
  Future<void> addAddress(AddressModel address) async {
    try {
      await _supabaseClient.from('addresses').insert(address.toJson());
    } catch (error) {
      throw SkException('Failed to add address: $error');
    }
  }

  @override
  Future<List<AddressModel>> getAddresses() async {
    try {
      final data = await _supabaseClient.from('addresses').select();
      return data.map((item) => AddressModel.fromJson(item)).toList();
    } catch (error) {
      throw SkException('Failed to fetch addresses: $error');
    }
  }

  @override
  Future<void> updateAddress(AddressModel address) async {
    try {
      await _supabaseClient
          .from('addresses')
          .update(address.toJson())
          .eq('id', address.id);
    } catch (error) {
      throw SkException('Failed to update address: $error');
    }
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    try {
      await _supabaseClient.from('addresses').delete().eq('id', addressId);
    } catch (error) {
      throw SkException('Failed to delete address: $error');
    }
  }
}

class FakeAddressRepository implements BaseAddressRepository {
  static final FakeAddressRepository _instance = FakeAddressRepository._();

  factory FakeAddressRepository() {
    return _instance;
  }

  FakeAddressRepository._(); // Private constructor

  final List<AddressModel> _addresses = [
    AddressModel(
      address: '123 Main Street',
      latlng: (lat: 51.5074, lng: 0.1278),
      ownerId: 'user123',
      createdAt: DateTime.now(),
      id: '1',
      category: AddressCategory.friend,
      label: 'Home',
      houseStreetNo: '57',
    ),
    AddressModel(
      address: '456 Elm Street',
      latlng: (lat: 51.5074, lng: 0.1278),
      createdAt: DateTime.now(),
      id: '2',
      houseStreetNo: '57',
      category: AddressCategory.office,
      label: 'Work',
    ),
    AddressModel(
      address: '789 Oak Street',
      latlng: (lat: 51.5074, lng: 0.1278),
      createdAt: DateTime.now(),
      id: '3',
      houseStreetNo: '57',
      category: AddressCategory.house,
      label: 'Vacation Home',
    ),
  ];

  @override
  Future<void> addAddress(AddressModel address) async {
    _addresses.add(address);
  }

  @override
  Future<List<AddressModel>> getAddresses() async {
    return await Future.delayed(const Duration(seconds: 2), () {
      return _addresses;
    });
  }

  @override
  Future<void> updateAddress(AddressModel address) async {
    final index = _addresses.indexWhere((a) => a.id == address.id);
    if (index != -1) {
      _addresses[index] = address;
    }
  }

  @override
  Future<void> deleteAddress(String addressId) async {
    _addresses.removeWhere((a) => a.id == addressId);
  }
}
