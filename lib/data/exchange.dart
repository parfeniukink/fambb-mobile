import 'package:json_annotation/json_annotation.dart';

import 'currency.dart';

part 'exchange.g.dart';

@JsonSerializable()
class ExchangeResult {
  final Exchange result;

  ExchangeResult({
    required this.result,
  });

  factory ExchangeResult.fromJson(Map<String, dynamic> json) =>
      _$ExchangeResultFromJson(json);
  Map<String, dynamic> toJson() => _$ExchangeResultToJson(this);
}

@JsonSerializable()
class Exchange {
  final int id;
  final double fromValue;
  final double toValue;
  final DateTime timestamp;
  final Currency fromCurrency;
  final Currency toCurrency;

  Exchange({
    required this.id,
    required this.fromValue,
    required this.toValue,
    required this.timestamp,
    required this.fromCurrency,
    required this.toCurrency,
  });

  factory Exchange.fromJson(Map<String, dynamic> json) =>
      _$ExchangeFromJson(json);
  Map<String, dynamic> toJson() => _$ExchangeToJson(this);
}

@JsonSerializable()
class ExchangeCreateBody {
  final double fromValue;
  final double toValue;
  final DateTime timestamp;
  final int fromCurrencyId;
  final int toCurrencyId;

  ExchangeCreateBody({
    required this.fromValue,
    required this.toValue,
    required this.timestamp,
    required this.fromCurrencyId,
    required this.toCurrencyId,
  });

  factory ExchangeCreateBody.fromJson(Map<String, dynamic> json) =>
      _$ExchangeCreateBodyFromJson(json);
  Map<String, dynamic> toJson() => _$ExchangeCreateBodyToJson(this);
}
