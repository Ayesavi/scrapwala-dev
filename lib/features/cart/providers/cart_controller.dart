import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/features/cart/repositories/cart_repository.dart';
import 'package:scrapwala_dev/models/cart_model/cart_model.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';

part 'cart_controller.freezed.dart';
part 'cart_controller.g.dart';
part 'cart_controller_state.dart';

@Riverpod(keepAlive: true)
class CartController extends _$CartController {
  final _repo = SupabaseCartRepository();
  var _cart = <CartModel>[];

  @override
  CartControllerState build() {
    getCartItems();
    return const _Initial();
  }

  void getCartItems() async {
    try {
      _cart = await _repo.getCartItems();
      state = _Data(_cart);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addCartItem(CartModel model) async {
    if (!isCartContains(model.scrap)) {
      _cart.add(await _repo.addToCart(model));
      state = _Data(_cart);
    } else {
      throw const SkException('Scrap has been already added!');
    }
    return;
  }

  Future<void> remooveItemFromCart(String itemId) async {
    final cartId =
        (_cart.firstWhere((element) => element.scrap.id == itemId)).id;
    await _repo.removeFromCart(cartId);
    _cart.removeWhere((e) => e.id == cartId);
    state = _Data(_cart);
  }

  void updateCartQty(String cartId, int newQty) {
    _repo.updateCartQty(cartId, newQty);
    final index = _cart.indexWhere((element) => element.id == cartId);
    _cart[index] = _cart[index].copyWith(qty: newQty);
    state = _Data(_cart);
  }

  /// Works locally only and hence do not come with
  /// capability of remote database until now
  bool isCartContains(ScrapModel model) {
    // Iterate through each item in the cart
    for (var cartItem in _cart) {
      // Check if the ID of the current cart item matches the ID of the given model
      if (cartItem.scrap.id == model.id) {
        // If a matching ID is found, return true
        return true;
      }
    }
    // If no matching ID is found after iterating through all cart items, return false
    return false;
  }

  // void requestPickUp(,context){

  // }
}
