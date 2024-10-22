// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExchangeResult _$ExchangeResultFromJson(Map<String, dynamic> json) =>
    ExchangeResult(
      result: Exchange.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExchangeResultToJson(ExchangeResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

Exchange _$ExchangeFromJson(Map<String, dynamic> json) => Exchange(
      id: (json['id'] as num).toInt(),
      fromValue: (json['fromValue'] as num).toDouble(),
      toValue: (json['toValue'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      fromCurrency:
          Currency.fromJson(json['fromCurrency'] as Map<String, dynamic>),
      toCurrency: Currency.fromJson(json['toCurrency'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ExchangeToJson(Exchange instance) => <String, dynamic>{
      'id': instance.id,
      'fromValue': instance.fromValue,
      'toValue': instance.toValue,
      'timestamp': instance.timestamp.toIso8601String(),
      'fromCurrency': instance.fromCurrency,
      'toCurrency': instance.toCurrency,
    };

ExchangeCreateBody _$ExchangeCreateBodyFromJson(Map<String, dynamic> json) =>
    ExchangeCreateBody(
      fromValue: (json['fromValue'] as num).toDouble(),
      toValue: (json['toValue'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      fromCurrencyId: (json['fromCurrencyId'] as num).toInt(),
      toCurrencyId: (json['toCurrencyId'] as num).toInt(),
    );

Map<String, dynamic> _$ExchangeCreateBodyToJson(ExchangeCreateBody instance) =>
    <String, dynamic>{
      'fromValue': instance.fromValue,
      'toValue': instance.toValue,
      'timestamp': instance.timestamp.toIso8601String(),
      'fromCurrencyId': instance.fromCurrencyId,
      'toCurrencyId': instance.toCurrencyId,
    };
