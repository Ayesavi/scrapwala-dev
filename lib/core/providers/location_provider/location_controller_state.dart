part of 'location_controller.dart';

@freezed
class LocationControllerState with _$LocationControllerState {
    const factory LocationControllerState.locationNotSet() = _Initial;
    const factory LocationControllerState.empty() = _Empty;

    const factory LocationControllerState.location(AddressModel model) = _Location;
}
