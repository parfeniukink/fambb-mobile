import 'package:json_annotation/json_annotation.dart';

part 'currency.g.dart';

@JsonSerializable()
class CurrencyResults {
  final List<Currency> result;

  CurrencyResults({
    required this.result,
  });

  factory CurrencyResults.fromJson(Map<String, dynamic> json) =>
      _$CurrencyResultsFromJson(json);
  Map<String, dynamic> toJson() => _$CurrencyResultsToJson(this);
}

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
