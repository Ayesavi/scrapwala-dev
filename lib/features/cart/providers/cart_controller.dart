import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/features/cart/repositories/cart_repository.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';

part 'cart_controller.freezed.dart';
part 'cart_controller.g.dart';
part 'cart_controller_state.dart';

@Riverpod(keepAlive: true)
class CartController extends _$CartController {
  final _repo = FakeCartRepository();
  var _cart = <ScrapModel>[];

  @override
  CartControllerState build() {
    getCartItems();
    return const _Initial();
  }

  void getCartItems() async {
    try {
      _cart = await _repo.getCartItems();
      state = _Data(_cart);
    } catch (e) {}
  }

  void addCartItem(ScrapModel model) {
    _repo.addToCart(model);
    _cart.add(model);
    state = _Data(_cart);
  }

  void remooveItemFromCart(String itemId) {
    _repo.removeFromCart(itemId);
    _cart.removeWhere((e) => e.id == itemId);
    state = _Data(_cart);
  }

  /// Works locally only and hence do not come with
  /// capability of remote database until now
  bool isCartContains(ScrapModel model) {
    return _cart.contains(model);
  }
}
