part of 'transactions_conroller.dart';

@freezed
class TransactionsConrollerState with _$TransactionsConrollerState {
  const factory TransactionsConrollerState.loading() = _Initial;
  const factory TransactionsConrollerState.data(List<PickupRequestModel> txns) =
      _Data;
}
