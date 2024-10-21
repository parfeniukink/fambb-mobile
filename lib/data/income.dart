import 'package:json_annotation/json_annotation.dart';

import 'currency.dart';

part 'income.g.dart';

@JsonSerializable()
class IncomeResult {
  final Income result;

  IncomeResult({
    required this.result,
  });

  factory IncomeResult.fromJson(Map<String, dynamic> json) =>
      _$IncomeResultFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeResultToJson(this);
}

@JsonSerializable()
class Income {
  final int id;
  final String name;
  final double value;
  final String source; // revenue, gift, debt, other
  final DateTime timestamp;
  final Currency currency;

  Income({
    required this.id,
    required this.name,
    required this.value,
    required this.source,
    required this.timestamp,
    required this.currency,
  });

  factory Income.fromJson(Map<String, dynamic> json) => _$IncomeFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeToJson(this);
}

@JsonSerializable()
class IncomeCreateBody {
  final String name;
  final double value;
  final String source;
  final DateTime timestamp;
  final int currencyId;

  IncomeCreateBody({
    required this.name,
    required this.value,
    required this.source,
    required this.timestamp,
    required this.currencyId,
  });

  factory IncomeCreateBody.fromJson(Map<String, dynamic> json) =>
      _$IncomeCreateBodyFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeCreateBodyToJson(this);
}

@JsonSerializable()
class IncomeUpdateBody {
  final String? name;
  final double? value;
  final String? source;
  final DateTime? timestamp;
  final int? currencyId;

  IncomeUpdateBody({
    this.name,
    this.value,
    this.source,
    this.timestamp,
    this.currencyId,
  });

  factory IncomeUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$IncomeUpdateBodyFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeUpdateBodyToJson(this);
}
