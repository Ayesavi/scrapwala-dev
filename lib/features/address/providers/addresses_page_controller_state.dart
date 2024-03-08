part of 'addresses_page_controller.dart';

@freezed
class AddressesPageControllerState with _$AddressesPageControllerState {
  const factory AddressesPageControllerState.loading() = _Loading;
  const factory AddressesPageControllerState.data(List<AddressModel> models) =
      _Data;
  const factory AddressesPageControllerState.error(Object e) = _Error;
}
