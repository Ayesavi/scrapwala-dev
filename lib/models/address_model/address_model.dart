import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

@freezed
class AddressModel with _$AddressModel {
  factory AddressModel({
    required String address,
    required String houseStreetNo,
    String? apartmentRoadAreadLandmark,
    required ({double lat, double lng}) latlng,
    String? ownerId,
    required DateTime createdAt,
    required String id,
    String? phoneNumber,
    required AddressCategory category,
    required String label,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}

enum AddressCategory { friend, house, office, others }

extension GetBool on AddressCategory {
  bool get isFriend => this == AddressCategory.friend;
  bool get isHouse => this == AddressCategory.house;
  bool get isOffice => this == AddressCategory.office;

  String get toName {
    return switch (this) {
      AddressCategory.friend => 'Friends and Family',
      AddressCategory.house => 'Home',
      AddressCategory.office => 'Work',
      AddressCategory.others => 'Others'
    };
  }

  Icon icon(BuildContext context, {Color? color}) {
    return switch (this) {
      AddressCategory.friend => Icon(
          Icons.group_outlined,
          color: color ??
              Theme.of(context).colorScheme.onBackground.withOpacity(.6),
        ),
      AddressCategory.house => Icon(
          Icons.home_outlined,
          color: color ??
              Theme.of(context).colorScheme.onBackground.withOpacity(.6),
        ),
      AddressCategory.office => Icon(
          Icons.maps_home_work_outlined,
          color: color ??
              Theme.of(context).colorScheme.onBackground.withOpacity(.6),
        ),
      AddressCategory.others => Icon(
          Icons.category,
          color: color ??
              Theme.of(context).colorScheme.onBackground.withOpacity(.6),
        ),
    };
  }

  IconData get toIcon {
    return switch (this) {
      AddressCategory.friend => (Icons.person_outline),
      AddressCategory.house => (Icons.home_outlined),
      AddressCategory.office => (Icons.work_outline),
      AddressCategory.others => (Icons.category),
    };
  }
}

extension ToSupa on AddressModel {
  Map<String, dynamic> toSupaJson() {
    final json = toJson();
    json['latlng'] = 'POINT(${json['latlng']['lng']} ${json['latlng']['lat']})';
    json.remove('id');
    json.remove('ownerId');

    return json;
  }
}
