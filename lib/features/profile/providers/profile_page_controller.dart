import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:scrapwala_dev/core/extensions/object_extension.dart';
import 'package:scrapwala_dev/features/profile/repositories/profile_repository.dart';
import 'package:scrapwala_dev/models/user_model/user_model.dart';

part 'profile_page_controller.freezed.dart';
part 'profile_page_controller.g.dart';
part 'profile_page_controller_state.dart';

@Riverpod(keepAlive: true)
class ProfilePageController extends _$ProfilePageController {
  final _repo = SupabaseProfileRepository();

  @override
  ProfilePageControllerState build() {
    getProfileDetails();
    return const _Loading();
  }

  void getProfileDetails() async {
    final model = await _repo.getProfileDetails();
    state = _Data(model);
  }

  Future<void> upateProfile(
      {String? name, String? email, String? phone}) async {
    if (name != null) {
      await _repo.updateProfile(name: name);
    } else if (email.isNotNull) {
      await _repo.updateProfile(email: email);
    } else if (phone.isNotNull) {
      await _repo.updateProfile(phone: phone);
    }
    getProfileDetails();
  }
}
