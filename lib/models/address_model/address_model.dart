import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

@freezed
class AddressModel with _$AddressModel {
  factory AddressModel({
    required String address,
    String? landmark,
    required ({double lat, double lng}) latlng,
    String? ownerId,
    required DateTime createdAt,
    required String id,
    required AddressCategory category,
    required String label,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}

enum AddressCategory {
  friend,
  house,
  office,
}

extension GetBool on AddressCategory {
  bool get isFriend => this == AddressCategory.friend;
  bool get isHouse => this == AddressCategory.house;
  bool get isOffice => this == AddressCategory.office;
}