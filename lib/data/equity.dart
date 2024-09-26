import 'package:json_annotation/json_annotation.dart';

import 'currency.dart';

part 'equity.g.dart';

@JsonSerializable()
class EquityResults {
  final List<Equity> result;

  EquityResults({
    required this.result,
  });

  factory EquityResults.fromJson(Map<String, dynamic> json) =>
      _$EquityResultsFromJson(json);

  Map<String, dynamic> toJson() => _$EquityResultsToJson(this);
}

@JsonSerializable()
class Equity {
  final Currency currency;
  final int amount;

  Equity({
    required this.currency,
    required this.amount,
  });

  factory Equity.fromJson(Map<String, dynamic> json) => _$EquityFromJson(json);

  Map<String, dynamic> toJson() => _$EquityToJson(this);
}
