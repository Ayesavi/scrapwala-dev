import 'package:freezed_annotation/freezed_annotation.dart';

part 'scrap_model.freezed.dart';
part 'scrap_model.g.dart';

enum ScrapMeasurement {
  /// Measured per unit
  unit,

  /// Measured per kilogram
  kg,

  /// Measured per gram
  gm,

  /// Measured per litre
  ltr,

  /// Measured per quintal (100 Kilogram)
  qntl,
}

extension ScrapMeasurementExtension on ScrapMeasurement {
  String get toName {
    switch (this) {
      case ScrapMeasurement.unit:
        return 'unit';
      case ScrapMeasurement.kg:
        return 'kilogram';
      case ScrapMeasurement.gm:
        return 'gram';
      case ScrapMeasurement.ltr:
        return 'litre';
      case ScrapMeasurement.qntl:
        return 'quintal';
      default:
        throw Exception('Unknown ScrapMeasurement value');
    }
  }
}

@freezed
abstract class ScrapModel with _$ScrapModel {
  const factory ScrapModel({
    required String id,
    required String name,
    String? photoUrl,
    required String description,
    required double price,
    @Default(ScrapMeasurement.kg) ScrapMeasurement measure,
    @Default(false) bool isNegotiable,
  }) = _ScrapModel;

  factory ScrapModel.fromJson(Map<String, dynamic> json) =>
      _$ScrapModelFromJson(json);
}
