import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/features/cart/repositories/cart_repository.dart';
import 'package:scrapwala_dev/models/cart_model/cart_model.dart';
import 'package:scrapwala_dev/models/pickup_request_model/pickup_request_model.dart';
import 'package:scrapwala_dev/shared/show_snackbar.dart';
import 'package:scrapwala_dev/widgets/cart_item_tile.dart';
import 'package:scrapwala_dev/widgets/requess_status_combined_widget.dart';
import 'package:scrapwala_dev/widgets/request_status_widget.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

part 'request_items_bottomsheet.g.dart';

@riverpod
Future<List<CartModel>> _getCartItem(_GetCartItemRef ref,
    {required String requestId}) async {
  return SupabaseCartRepository().getCartItemsByReqId(requestId);
}

Future<void> showRequestContentsBottomSheet(BuildContext context,
    {required PickupRequestModel requestModel}) async {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return _RequestContentsBottomSheetWidget(requestModel: requestModel);
    },
  );
}

class _RequestContentsBottomSheetWidget extends ConsumerWidget {
  final PickupRequestModel requestModel;

  const _RequestContentsBottomSheetWidget(
      {super.key, required this.requestModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const HeadlineSmall(
                    text: 'Scrap Items',
                    weight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showStatusBottomSheet(context,
                                models: [requestModel]);
                            FirebaseAnalytics.instance
                                .logEvent(name: 'track_request_status');
                          },
                          tooltip: 'Track Status',
                          icon: const Icon(
                            Icons.track_changes,
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      RequestStatusWidget(requestModel.status),
                    ],
                  )
                ],
              ),
            ),
            Builder(builder: (context) {
              final items =
                  ref.watch(_getCartItemProvider(requestId: requestModel.id));
              return items.when(
                  data: (models) {
                    return Flexible(
                      child: ListView.builder(
                        itemCount:
                            models.length, // Replace with the actual item count
                        itemBuilder: (context, index) {
                          return CartItemTile(model: models[index]);
                        },
                      ),
                    );
                  },
                  error: (e, s) {
                    Future.delayed(const Duration(milliseconds: 200), () {
                      showSnackBar(context, 'Look\'s like an error Occurred');
                      Navigator.pop(context);
                    });
                    return const SizedBox();
                  },
                  loading: () => const Center(
                        child: CupertinoActivityIndicator(),
                      ));
            }),
          ],
        ),
      ),
    );
  }
}
