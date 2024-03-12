import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/models/cart_model/cart_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseCartRepository {
  Future<List<CartModel>> getCartItems();

  Future<void> addToCart(CartModel cartItem);

  Future<void> removeFromCart(String itemId);
}

class SupabaseCartRepository implements BaseCartRepository {
  final _supabaseClient = Supabase.instance.client;

  @override
  Future<List<CartModel>> getCartItems() async {
    try {
      final data = await _supabaseClient
          .from('cart')
          .select("*,scrap:scrap_id(*)")
          .isFilter('request_id', null);
      return data.map((item) => CartModel.fromJson(item)).toList();
    } catch (error) {
      throw SkException('Failed to fetch cart items: $error');
    }
  }

  @override
  Future<void> addToCart(CartModel cartItem) async {
    try {
      await _supabaseClient.from('cart').insert({
        "qty": cartItem.qty,
        'scrap_id': cartItem.scrap.id,
      });
    } catch (error) {
      throw SkException('Failed to add item to cart: $error');
    }
  }

  @override
  Future<void> removeFromCart(String itemId) async {
    try {
      await _supabaseClient.from('cart').delete().eq('id', itemId);
    } catch (error) {
      throw SkException('Failed to remove item from cart: $error');
    }
  }
}

class FakeCartRepository implements BaseCartRepository {
  final List<CartModel> _cartItems = []; // Dummy storage for cart items

  @override
  Future<List<CartModel>> getCartItems() async {
    return List.from(_cartItems); // Return the list of cart items
  }

  @override
  Future<void> addToCart(CartModel cartItem) async {
    _cartItems.add(cartItem); // Add the item to the cart
  }

  @override
  Future<void> removeFromCart(String itemId) async {
    _cartItems
        .removeWhere((item) => item.id == itemId); // Remove item from the cart
  }
}
