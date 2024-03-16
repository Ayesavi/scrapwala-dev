import 'package:scrapwala_dev/models/address_model/address_model.dart';
import 'package:scrapwala_dev/models/pickup_request_model/pickup_request_model.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';
import 'package:scrapwala_dev/models/transaction_model/transaction_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final List<TransactionModel> randomTransactionModels = [
  TransactionModel(
    transactionId: '1',
    requestId: 'REQ1',
    pickupLocation: AddressModel(
      address: '123 Main St',
      houseStreetNo: 'Apt 2B',
      latlng: (lat: 40.7128, lng: -74.006),
      createdAt: DateTime.now(),
      id: '1',
      category: AddressCategory.house,
      label: 'Home',
    ),
    pickupTime: DateTime.now(),
    orders: [
      OrderQuantity(
        id: '1',
        name: 'Aluminum Cans',
        measurement: ScrapMeasurement.kg,
        quantity: 5,
        price: 20,
      ),
      OrderQuantity(
        id: '2',
        name: 'Copper Wire',
        measurement: ScrapMeasurement.qntl,
        quantity: 1,
        price: 50,
      ),
    ],
    totalAmountPaid: 150,
  ),
  TransactionModel(
    transactionId: '2',
    requestId: 'REQ2',
    pickupLocation: AddressModel(
      address: '456 Elm St',
      houseStreetNo: 'Suite 3C',
      latlng: (lat: 40.7282, lng: -73.7949),
      createdAt: DateTime.now(),
      id: '2',
      category: AddressCategory.office,
      label: 'Work',
    ),
    pickupTime: DateTime.now(),
    orders: [
      OrderQuantity(
        id: '3',
        name: 'Steel Scrap',
        measurement: ScrapMeasurement.kg,
        quantity: 10,
        price: 15,
      ),
    ],
    totalAmountPaid: 150,
  ),
  // Add more transactions as needed...
];
final List<PickupRequestModel> randomPickupRequests = [
  PickupRequestModel(
    addressId: '1',
    id: 'REQ1',
    requestDateTime: DateTime(2024, 3, 11, 8, 0, 0),
    requestingUserId: 'user123',
    scheduleDateTime: DateTime(2024, 3, 12, 10, 0, 0),
    qtyRange: '20-30',
    status: RequestStatus.picked,
  ),
  PickupRequestModel(
    addressId: '2',
    id: 'REQ2',
    requestDateTime: DateTime(2024, 3, 10, 9, 0, 0),
    requestingUserId: 'user456',
    scheduleDateTime: DateTime(2024, 3, 13, 12, 0, 0),
    qtyRange: '20-30',
    status: RequestStatus.picked,
  ),
  PickupRequestModel(
    addressId: '3',
    id: 'REQ3',
    requestDateTime: DateTime(2024, 3, 9, 10, 0, 0),
    requestingUserId: 'user789',
    scheduleDateTime: DateTime(2024, 3, 14, 9, 0, 0),
    qtyRange: '20-30',
    status: RequestStatus.requested,
  ),
  PickupRequestModel(
    addressId: '4',
    id: 'REQ4',
    requestDateTime: DateTime(2024, 3, 8, 11, 0, 0),
    requestingUserId: 'user101112',
    scheduleDateTime: DateTime(2024, 3, 15, 14, 0, 0),
    qtyRange: '20-30',
    status: RequestStatus.denied,
  ),
  PickupRequestModel(
    addressId: '5',
    id: 'REQ5',
    requestDateTime: DateTime(2024, 3, 7, 12, 0, 0),
    requestingUserId: 'user131415',
    scheduleDateTime: DateTime(2024, 3, 16, 11, 0, 0),
    qtyRange: '20-30',
    status: RequestStatus.picked,
  ),
];

abstract class BaseTransactionRepository {
  Future<List<PickupRequestModel>> getPrevRequests();
  Future<TransactionModel> getTransactionById(String id);
}

class FakeTxnRepository implements BaseTransactionRepository {
  @override
  Future<List<PickupRequestModel>> getPrevRequests() async {
    await Future.delayed(const Duration(seconds: 1), () {});
    return List.from(randomPickupRequests);
  }

  @override
  Future<TransactionModel> getTransactionById(String id) async {
    await Future.delayed(const Duration(seconds: 1), () {});

    return randomTransactionModels
        .where((element) => element.requestId == id)
        .toList()
        .first;
  }
}

class SupabaseTxnRepository implements BaseTransactionRepository {
  final _supabaseClient = Supabase.instance.client;

  @override
  Future<List<PickupRequestModel>> getPrevRequests() async {
    final data =
        await _supabaseClient.from('requests').select('*,address:addressId(*)');
    return data.map((e) => PickupRequestModel.fromJson(e)).toList();
  }

  @override
  Future<TransactionModel> getTransactionById(String id) async {
    throw 'error';
  }
}
