part of 'profile_page_controller.dart';

@freezed
class ProfilePageControllerState with _$ProfilePageControllerState {
    const factory ProfilePageControllerState.loading() = _Loading;
    const factory ProfilePageControllerState.data(UserModel model) = _Data;
}
