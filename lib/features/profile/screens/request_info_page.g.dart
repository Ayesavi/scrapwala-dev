// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_info_page.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$txnHash() => r'449d12e6c0ce476331d0a38c4fce65607a812040';

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

/// See also [txn].
@ProviderFor(txn)
const txnProvider = TxnFamily();

/// See also [txn].
class TxnFamily extends Family<AsyncValue<TransactionModel>> {
  /// See also [txn].
  const TxnFamily();

  /// See also [txn].
  TxnProvider call(
    String id,
  ) {
    return TxnProvider(
      id,
    );
  }

  @override
  TxnProvider getProviderOverride(
    covariant TxnProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'txnProvider';
}

/// See also [txn].
class TxnProvider extends AutoDisposeFutureProvider<TransactionModel> {
  /// See also [txn].
  TxnProvider(
    String id,
  ) : this._internal(
          (ref) => txn(
            ref as TxnRef,
            id,
          ),
          from: txnProvider,
          name: r'txnProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$txnHash,
          dependencies: TxnFamily._dependencies,
          allTransitiveDependencies: TxnFamily._allTransitiveDependencies,
          id: id,
        );

  TxnProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    FutureOr<TransactionModel> Function(TxnRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TxnProvider._internal(
        (ref) => create(ref as TxnRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<TransactionModel> createElement() {
    return _TxnProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TxnProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TxnRef on AutoDisposeFutureProviderRef<TransactionModel> {
  /// The parameter `id` of this provider.
  String get id;
}

class _TxnProviderElement
    extends AutoDisposeFutureProviderElement<TransactionModel> with TxnRef {
  _TxnProviderElement(super.provider);

  @override
  String get id => (origin as TxnProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
