import 'package:json_annotation/json_annotation.dart';

part 'finances.g.dart';

@JsonSerializable()
class Currency {
  final int id;
  final String name;
  final String sign;

  Currency({
    required this.id,
    required this.name,
    required this.sign,
  });

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}
