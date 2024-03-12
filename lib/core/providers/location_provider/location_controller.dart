import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/features/address/repositories/address_repository.dart';
import 'package:scrapwala_dev/features/auth/controllers/auth_controller.dart';
import 'package:scrapwala_dev/models/address_model/address_model.dart';

part 'location_controller.freezed.dart';
part 'location_controller.g.dart';
part 'location_controller_state.dart';

@Riverpod(keepAlive: true)
class LocationController extends _$LocationController {
  final _repo = SupabaseAddressRepository();

  var _addresses = <AddressModel>[];

  List<AddressModel> get address => _addresses;

  @override
  LocationControllerState build() {
    ref.watch(authStateChangesProvider);

    fetchAddresses();
    return const _Initial();
  }

  void setLocation(AddressModel addrModel) {
    state = _Location(addrModel);
  }

  void fetchAddresses() async {
    final addrs = await Future.delayed(const Duration(seconds: 1), () async {
      return await _repo.getAddresses();
    });

    _addresses = addrs;
    if (addrs.isNotEmpty) {
      // TODO: personalised address from sharedPreferences
      state = _Location(addrs[0]);
    }
    if (addrs.isEmpty) {
      state = const _Empty();
    }
  }
}
