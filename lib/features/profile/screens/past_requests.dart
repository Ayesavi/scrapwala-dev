import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/features/profile/providers/transaction_controller/transactions_conroller.dart';
import 'package:scrapwala_dev/shimmering_widgets/pickup_request_tile.dart';
import 'package:scrapwala_dev/widgets/past_pickup_request_tile.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class PastRequestsPage extends ConsumerWidget {
  const PastRequestsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txnState = ref.watch(transactionsConrollerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const TitleMedium(
          text: 'Past Requests',
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
      body: CustomScrollView(
        slivers: [
          txnState.when(loading: () {
            return SliverList(
              delegate: SliverChildBuilderDelegate((ctx, index) {
                return const ShimmeringPickRequestTile();
              }, childCount: 12),
            );
          }, data: (requests) {
            return SliverList(
              delegate: SliverChildBuilderDelegate((ctx, index) {
                return PickRequestTile(
                  model: requests[index],
                  onTap: (model) {
                    RequestInfoPageRoute(model.id).push(context);
                  },
                );
              }, childCount: requests.length),
            );
          })
        ],
      ),
    );
  }
}
