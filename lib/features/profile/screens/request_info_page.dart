import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/core/constants/string_constants.dart';
import 'package:scrapwala_dev/features/profile/repositories/transactions_repository.dart';
import 'package:scrapwala_dev/models/transaction_model/transaction_model.dart';
import 'package:scrapwala_dev/shimmering_widgets/shimmering_address_tile.dart';
import 'package:scrapwala_dev/shimmering_widgets/shimmering_container.dart';
import 'package:scrapwala_dev/shimmering_widgets/shimmering_dotted_line.dart';
import 'package:scrapwala_dev/shimmering_widgets/shimmering_listtile.dart';
import 'package:scrapwala_dev/shimmering_widgets/shimmering_map_table.dart';
import 'package:scrapwala_dev/widgets/address_tile.dart';
import 'package:scrapwala_dev/widgets/dotted_line.dart';
import 'package:scrapwala_dev/widgets/table_widget.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

part 'request_info_page.g.dart';

@riverpod
Future<TransactionModel> txn(TxnRef ref, String id) async {
  return await FakeTxnRepository().getTransactionById(id);
}

class RequestInfoPage extends ConsumerWidget {
  final String requestId;

  const RequestInfoPage({super.key, required this.requestId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaction = ref.watch(txnProvider(requestId));
    return Scaffold(
        appBar: AppBar(
          title: TitleMedium(
            text: "#$requestId",
            weight: FontWeight.bold,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ElevatedButton(
                child: const Text('Help'),
                onPressed: () {},
              ),
            )
          ],
        ),
        body: transaction.when(data: (data) {
          return Column(
            children: [
              AddressTile(
                model: data.pickupLocation,
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.check_circle_sharp,
                  color: Colors.greenAccent,
                ),
                title: LabelMedium(
                    text:
                        'Scrap picked on ${DateFormat('d MMMM h:mm a').format(data.pickupTime)}'),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.onInverseSurface,
                child: const Text('Scrap Details'),
              ),
              Flexible(child: MapTableWidget(data: data.orders)),
              const SizedBox(
                height: 20,
              ),
              DottedLine(height: MediaQuery.sizeOf(context).width - 32),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TitleMedium(text: "Total Bill Paid"),
                    TitleMedium(
                        text:
                            "$kRupeeSymbol ${data.totalAmountPaid.toString()}")
                  ],
                ),
              ),
              DottedLine(height: MediaQuery.sizeOf(context).width - 32),
            ],
          );
        }, error: (e, s) {
          return const Center(child: Text("An error Occurred"));
        }, loading: () {
          return const ShimmeringRequestInfoPage();
        }));
  }
}

class ShimmeringRequestInfoPage extends StatelessWidget {
  const ShimmeringRequestInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShimmeringAddressTile(),
          Divider(),
          ShimmeringListTile(),
          ShimmeringContainer(),
          SizedBox(height: 20),
          ShimmeringMapTableWidget(),
          SizedBox(height: 20),
          ShimmeringDottedLine(),
          ShimmeringDottedLine(),
        ],
      ),
    );
  }
}
