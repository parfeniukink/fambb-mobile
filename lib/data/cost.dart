import 'package:json_annotation/json_annotation.dart';

part 'cost.g.dart';

@JsonSerializable()
class CostCreateBody {
  final String name;
  final double value;
  final DateTime timestamp;
  final int currencyId;
  final int categoryId;

  CostCreateBody({
    required this.name,
    required this.value,
    required this.timestamp,
    required this.currencyId,
    required this.categoryId,
  });

  factory CostCreateBody.fromJson(Map<String, dynamic> json) =>
      _$CostCreateBodyFromJson(json);
  Map<String, dynamic> toJson() => _$CostCreateBodyToJson(this);
}
