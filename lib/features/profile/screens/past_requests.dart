import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/features/profile/repositories/transactions_repository.dart';
import 'package:scrapwala_dev/models/pickup_request_model/pickup_request_model.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';
import 'package:scrapwala_dev/shimmering_widgets/pickup_request_tile.dart';
import 'package:scrapwala_dev/widgets/past_pickup_request_tile.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

part 'past_requests.g.dart';

@riverpod
Future<List<PickupRequestModel>> prevRequests(PrevRequestsRef ref) async {
  return await SupabaseTxnRepository().getPrevRequests();
}

class PastRequestsPage extends ConsumerWidget {
  const PastRequestsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final txnState = ref.watch(prevRequestsProvider);

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
                    if (model.status == RequestStatus.picked) {
                      RequestInfoPageRoute(model.id).push(context);
                    } else {
                      showSnackBar(
                          context, 'The Pick up Request has to be picked');
                    }
                  },
                );
              }, childCount: requests.length),
            );
          }, error: (e, s) {
            Future.delayed(const Duration(seconds: 1), () {
              showSnackBar(context, 'Looks like an error occurred');
            });
            return SliverList(
              delegate: SliverChildBuilderDelegate((ctx, index) {
                return const ShimmeringPickRequestTile();
              }, childCount: 12),
            );
          })
        ],
      ),
    );
  }
}
