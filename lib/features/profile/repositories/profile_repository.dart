import 'package:scrapwala_dev/core/extensions/object_extension.dart';
import 'package:scrapwala_dev/features/auth/repositories/auth_repository.dart';
import 'package:scrapwala_dev/models/user_model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileRepository {
  Future<UserModel> getProfileDetails();

  Future<void> updateProfile({String? name, String? email, String? phone});
}

class SupabaseProfileRepository implements ProfileRepository {
  final _supabaseClient = Supabase.instance.client;

  @override
  Future<UserModel> getProfileDetails() async {
    final sessionUser = await _supabaseClient.auth.getUser();
    final metadata = sessionUser.user?.userMetadata;
    if (sessionUser.user.isNotNull) {
      return UserModel(
          id: sessionUser.user!.id,
          email: sessionUser.user!.email,
          phoneNumber: metadata?.containsKey("phone") ?? false
              ? metadata!['phone']
              : null,
          name: metadata?.containsKey("full_name") ?? false
              ? metadata!['full_name']
              : null);
    }
    throw UnAuthenticatedUserException();
  }

  @override
  Future<void> updateProfile(
      {String? name, String? email, String? phone}) async {
    if (name != null) {
      await _supabaseClient.auth
          .updateUser(UserAttributes(data: {"full_name": name}));
    } else if (email.isNotNull) {
      await _supabaseClient.auth.updateUser(UserAttributes(email: email));
    } else if (phone.isNotNull) {
      await _supabaseClient.auth
          .updateUser(UserAttributes(data: {'phone': phone}));
    }
  }
}

class FakeProfileRepository implements ProfileRepository {
  final _model = const UserModel(
      id: "",
      name: "yogesh dubey",
      email: "yogesh.dubey.0804@gmail.com",
      phoneNumber: "917489016865");
  // Dummy storage for profile details

  @override
  Future<UserModel> getProfileDetails() async {
    return await Future.delayed(const Duration(seconds: 1), () {
      return _model;
    }); // Return the list of profiles
  }

  @override
  Future<void> updateProfile({String? name, String? email, String? phone}) {
    // TODO: implement updateProfile
    throw UnimplementedError();
  }
}
