import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/models/pickup_request_model/pickup_request_model.dart';
import 'package:scrapwala_dev/widgets/past_pickup_request_tile.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          title: const TitleMedium(
            text: 'Profile Page',
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: TitleLarge(
                    text: "YOGESH DUBEY".toUpperCase(),
                    weight: FontWeight.bold,
                    spacing: 3),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const LabelMedium(
                          text: '+91-7489016865 | yogesh.dubey.0804@gmail.com'),
                      TextButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 5)),
                          ),
                          onPressed: () {
                            const EditProfileRoute().push(context);
                          },
                          child: const Text('Edit Profile >'))
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(
                  thickness: 2,
                ),
              ),
              ListTile(
                onTap: () {},
                title: const TitleMedium(text: 'Addresses'),
                subtitle: const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: LabelMedium(text: "Share, Edit, Add new Addresses"),
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(),
              ),
              ListTile(
                onTap: () {},
                title: const TitleMedium(text: 'Transactions'),
                subtitle: const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: LabelMedium(text: "Payments and Transactions"),
                ),
                trailing: const Icon(Icons.chevron_right),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.onInverseSurface,
                child: const Text('Past Requests'),
              ),
              PickRequestTile(
                model: PickupRequestModel(
                    addressId: '',
                    status: RequestStatus.denied,
                    id: '168520888534237',
                    requestDateTime: DateTime.now(),
                    requestingUserId: '',
                    totalPrice: 2,
                    quantity: {}),
                onTap: (PickupRequestModel model) {
                  RequestInfoPageRoute(model.id).push(context);
                },
              ),
              PickRequestTile(
                model: PickupRequestModel(
                    addressId: '',
                    status: RequestStatus.picked,
                    id: '168520888534237',
                    requestDateTime: DateTime.now(),
                    requestingUserId: '',
                    totalPrice: 2,
                    quantity: {}),
                onTap: (PickupRequestModel model) {},
              ),
              PickRequestTile(
                model: PickupRequestModel(
                    addressId: '',
                    status: RequestStatus.pending,
                    id: '168520888534237',
                    requestDateTime: DateTime.now(),
                    requestingUserId: '',
                    totalPrice: 2,
                    quantity: {}),
                onTap: (PickupRequestModel model) {},
              )
            ],
          ),
        ));
  }
}
