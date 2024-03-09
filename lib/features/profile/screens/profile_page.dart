import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/extensions/string_extension.dart';
import 'package:scrapwala_dev/core/router/routes.dart';
import 'package:scrapwala_dev/features/auth/controllers/auth_controller.dart';
import 'package:scrapwala_dev/features/profile/providers/profile_page_controller.dart';
import 'package:scrapwala_dev/models/pickup_request_model/pickup_request_model.dart';
import 'package:scrapwala_dev/models/user_model/user_model.dart';
import 'package:scrapwala_dev/shimmering_widgets/profile_tile.dart';
import 'package:scrapwala_dev/widgets/logout_popup.dart';
import 'package:scrapwala_dev/widgets/past_pickup_request_tile.dart';
import 'package:scrapwala_dev/widgets/text_widgets.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  getProfileSubtitle(UserModel model) {
    if (model.phoneNumber.isNotNullAndNotEmpty &&
        (model.email.mayBeNullOrEmpty)) {
      return '+91${model.phoneNumber!.substring(2)}';
    } else if (model.phoneNumber.mayBeNullOrEmpty &&
        model.email.isNotNullAndNotEmpty) {
      return '${model.email}';
    } else {
      return '+91-${model.phoneNumber} | ${model.email}';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profilePageControllerProvider);
    final controller = ref.read(profilePageControllerProvider.notifier);
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
        body: RefreshIndicator(
          onRefresh: () async {
            controller.getProfileDetails();
          },
          child: ListView(
            children: [
              Column(
                children: [
                  state.when(
                      loading: () => const ShimmeringProfileWidget(),
                      data: (userModel) {
                        return ListTile(
                          title: TitleLarge(
                              text: userModel.name?.toUpperCase() ?? "",
                              weight: FontWeight.bold,
                              spacing: 3),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LabelMedium(
                                    text: getProfileSubtitle(userModel)),
                                TextButton(
                                    style: ButtonStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
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
                        );
                      }),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      thickness: 2,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      const AddressPageRoute().push(context);
                    },
                    title: const TitleMedium(text: 'Addresses'),
                    subtitle: const Padding(
                      padding: EdgeInsets.all(2.0),
                      child:
                          LabelMedium(text: "Share, Edit, Add new Addresses"),
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
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(),
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const TitleMedium(text: 'Logout'),
                    onTap: () {
                      showLogOutPopup(context, onConfirm: () {
                        ref.read(authControllerProvider).signOut();
                      });
                      // Call the onPressed callback when the ListTile is tapped
                    },
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
            ],
          ),
        ));
  }
}
