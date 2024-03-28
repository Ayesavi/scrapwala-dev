// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_items_bottomsheet.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getCartItemHash() => r'612f33a846fa381d431d97a0a96c48c92d390b17';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [_getCartItem].
@ProviderFor(_getCartItem)
const _getCartItemProvider = _GetCartItemFamily();

/// See also [_getCartItem].
class _GetCartItemFamily extends Family<AsyncValue<List<CartModel>>> {
  /// See also [_getCartItem].
  const _GetCartItemFamily();

  /// See also [_getCartItem].
  _GetCartItemProvider call({
    required String requestId,
  }) {
    return _GetCartItemProvider(
      requestId: requestId,
    );
  }

  @override
  _GetCartItemProvider getProviderOverride(
    covariant _GetCartItemProvider provider,
  ) {
    return call(
      requestId: provider.requestId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'_getCartItemProvider';
}

/// See also [_getCartItem].
class _GetCartItemProvider extends AutoDisposeFutureProvider<List<CartModel>> {
  /// See also [_getCartItem].
  _GetCartItemProvider({
    required String requestId,
  }) : this._internal(
          (ref) => _getCartItem(
            ref as _GetCartItemRef,
            requestId: requestId,
          ),
          from: _getCartItemProvider,
          name: r'_getCartItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCartItemHash,
          dependencies: _GetCartItemFamily._dependencies,
          allTransitiveDependencies:
              _GetCartItemFamily._allTransitiveDependencies,
          requestId: requestId,
        );

  _GetCartItemProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.requestId,
  }) : super.internal();

  final String requestId;

  @override
  Override overrideWith(
    FutureOr<List<CartModel>> Function(_GetCartItemRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: _GetCartItemProvider._internal(
        (ref) => create(ref as _GetCartItemRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        requestId: requestId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CartModel>> createElement() {
    return _GetCartItemProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _GetCartItemProvider && other.requestId == requestId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, requestId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin _GetCartItemRef on AutoDisposeFutureProviderRef<List<CartModel>> {
  /// The parameter `requestId` of this provider.
  String get requestId;
}

class _GetCartItemProviderElement
    extends AutoDisposeFutureProviderElement<List<CartModel>>
    with _GetCartItemRef {
  _GetCartItemProviderElement(super.provider);

  @override
  String get requestId => (origin as _GetCartItemProvider).requestId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
