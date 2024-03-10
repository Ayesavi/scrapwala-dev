import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/models/scrap_model/scrap_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseCartRepository {
  Future<List<ScrapModel>> getCartItems();

  Future<void> addToCart(ScrapModel cartItem);

  Future<void> updateCartItem(ScrapModel updatedCartItem);

  Future<void> removeFromCart(String itemId);
}

class SupabaseCartRepository implements BaseCartRepository {
  final _supabaseClient = Supabase.instance.client;

  @override
  Future<List<ScrapModel>> getCartItems() async {
    try {
      final data = await _supabaseClient.from('cart').select();
      return data.map((item) => ScrapModel.fromJson(item)).toList();
    } catch (error) {
      throw SkException('Failed to fetch cart items: $error');
    }
  }

  @override
  Future<void> addToCart(ScrapModel cartItem) async {
    try {
      await _supabaseClient.from('cart').insert(cartItem.toJson());
    } catch (error) {
      throw SkException('Failed to add item to cart: $error');
    }
  }

  @override
  Future<void> updateCartItem(ScrapModel updatedCartItem) async {
    try {
      await _supabaseClient
          .from('cart')
          .update(updatedCartItem.toJson())
          .eq('id', updatedCartItem.id);
    } catch (error) {
      throw SkException('Failed to update cart item: $error');
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
  final List<ScrapModel> _cartItems = []; // Dummy storage for cart items

  @override
  Future<List<ScrapModel>> getCartItems() async {
    return List.from(_cartItems); // Return the list of cart items
  }

  @override
  Future<void> addToCart(ScrapModel cartItem) async {
    _cartItems.add(cartItem); // Add the item to the cart
  }

  @override
  Future<void> updateCartItem(ScrapModel updatedCartItem) async {
    final index =
        _cartItems.indexWhere((item) => item.id == updatedCartItem.id);
    if (index != -1) {
      _cartItems[index] = updatedCartItem; // Update the cart item
    } else {
      throw Exception('Cart item not found');
    }
  }

  @override
  Future<void> removeFromCart(String itemId) async {
    _cartItems
        .removeWhere((item) => item.id == itemId); // Remove item from the cart
  }
}
