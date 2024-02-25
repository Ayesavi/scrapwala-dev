import 'package:flutter/material.dart';
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

  String get toName {
    return switch (this) {
      AddressCategory.friend => 'Friends and Family',
      AddressCategory.house => 'Home',
      AddressCategory.office => 'Work',
    };
  }

  IconData get toIcon {
    return switch (this) {
      AddressCategory.friend => (Icons.person_outline),
      AddressCategory.house => (Icons.home_outlined),
      AddressCategory.office => (Icons.work_outline),
    };
  }
}
