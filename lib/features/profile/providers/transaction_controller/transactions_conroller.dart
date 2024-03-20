import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/features/profile/repositories/transactions_repository.dart';
import 'package:scrapwala_dev/models/pickup_request_model/pickup_request_model.dart';

part 'transactions_conroller.freezed.dart';
part 'transactions_conroller.g.dart';
part 'transactions_conroller_state.dart';

@riverpod
class TransactionsConroller extends _$TransactionsConroller {
  final _repo = SupabaseTxnRepository();

  @override
  TransactionsConrollerState build() {
    getTransactions();
    return const _Initial();
  }

  void getTransactions() async {
    final txns = await _repo.getPrevRequests();
    state = _Data(txns);
  }
}
