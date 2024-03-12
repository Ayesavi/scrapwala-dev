part of 'cart_controller.dart';

@freezed
class CartControllerState with _$CartControllerState {
  const factory CartControllerState.initial() = _Initial;
  const factory CartControllerState.data(List<CartModel> scraps) = _Data;
}
