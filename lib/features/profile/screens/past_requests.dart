import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/features/profile/repositories/transactions_repository.dart';
import 'package:scrapwala_dev/models/pickup_request_model/pickup_request_model.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';
import 'package:scrapwala_dev/shimmering_widgets/pickup_request_tile.dart';
import 'package:scrapwala_dev/widgets/past_pickup_request_tile.dart';
import 'package:scrapwala_dev/widgets/request_items_bottomsheet.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

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
              onPressed: () async {
                if (!await launchUrl(
                    Uri.parse('https://www.swachhkabadi.com/help-center'))) {
                  throw Exception('Could not launch url');
                }
              },
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
            requests
                .sort((a, b) => b.requestDateTime.compareTo(a.requestDateTime));
            if (requests.isNotEmpty) {
              return SliverList(
                delegate: SliverChildBuilderDelegate((ctx, index) {
                  return PickRequestTile(
                    model: requests[index],
                    onTap: (model) {
                      if (model.status == RequestStatus.picked) {
                        RequestInfoPageRoute(model.id).push(context);
                      } else {
                        showRequestContentsBottomSheet(context,
                            requestModel: model);
                      }
                    },
                  );
                }, childCount: requests.length),
              );
            } else {
              return const SliverFillRemaining(
                child: Center(
                  child: BodyLarge(text: "No past requests to display"),
                ),
              );
            }
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
