import 'package:scrapwala_dev/core/error_handler/error_handler.dart';
import 'package:scrapwala_dev/models/cart_model/cart_model.dart';
import 'package:scrapwala_dev/models/pickup_request_model/pickup_request_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseCartRepository {
  Future<List<CartModel>> getCartItems();

  Future<List<CartModel>> getCartItemsByReqId(String id);

  Future<CartModel> addToCart(CartModel cartItem);

  Future<void> updateCartQty(String cartId, int newQty);

  Future<void> removeFromCart(String itemId);

  Future<PickupRequestModel> requestPickup({
    DateTime? scheduleTime,
    required String addressId,
    required String qtyRange,
  });

  /// Used to fetch request's which has been requested recently
  /// and whose status is not equal to picked/denied
  Future<List<PickupRequestModel>> getCurrentlyRequestedReqs();
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
  Future<CartModel> addToCart(CartModel cartItem) async {
    try {
      final data = await _supabaseClient
          .from('cart')
          .insert({
            "id": cartItem.id,
            "qty": cartItem.qty,
            'scrap_id': cartItem.scrap.id,
          })
          .select()
          .single();
      data['scrap'] = cartItem.scrap.toJson();
      return CartModel.fromJson(data);
    } catch (error) {
      throw errorHandler(error);
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

  @override
  Future<void> updateCartQty(String cartId, int newQty) async {
    try {
      await _supabaseClient
          .from('cart')
          .update({'qty': newQty}).eq('id', cartId);
    } catch (error) {
      throw SkException('Failed to remove item from cart: $error');
    }
  }

  @override
  Future<PickupRequestModel> requestPickup(
      {DateTime? scheduleTime,
      required String addressId,
      required String qtyRange}) async {
    final response =
        await _supabaseClient.rpc('handle_pickup_request', params: {
      "schedule_date_time": scheduleTime?.toIso8601String(),
      "address_id": addressId,
      "qty_range": qtyRange
    }).single();

    return PickupRequestModel.fromJson(response);
  }

  @override
  Future<List<PickupRequestModel>> getCurrentlyRequestedReqs() async {
    final response = await _supabaseClient
        .from('requests')
        .select('*')
        .neq('status', RequestStatus.picked.name)
        .neq('status', RequestStatus.denied.name);
    return response.map((e) => PickupRequestModel.fromJson(e)).toList();
  }

  @override
  Future<List<CartModel>> getCartItemsByReqId(id) async {
    try {
      final data = await _supabaseClient
          .from('cart')
          .select("*,scrap:scrap_id(*)")
          .eq('request_id', id);
      return data.map((item) => CartModel.fromJson(item)).toList();
    } catch (error) {
      throw SkException('Failed to fetch cart items: $error');
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
  Future<CartModel> addToCart(CartModel cartItem) async {
    _cartItems.add(cartItem); // Add the item to the cart

    return cartItem;
  }

  @override
  Future<void> removeFromCart(String itemId) async {
    _cartItems
        .removeWhere((item) => item.id == itemId); // Remove item from the cart
  }

  @override
  Future<void> updateCartQty(String cartId, int newQty) {
    throw UnimplementedError();
  }

  @override
  Future<PickupRequestModel> requestPickup(
      {DateTime? scheduleTime,
      required String addressId,
      required String qtyRange}) {
    throw UnimplementedError();
  }

  @override
  Future<List<PickupRequestModel>> getCurrentlyRequestedReqs() {
    throw UnimplementedError();
  }

  @override
  Future<List<CartModel>> getCartItemsByReqId(id) {
    throw UnimplementedError();
  }
}
