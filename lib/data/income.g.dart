// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'income.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IncomeResult _$IncomeResultFromJson(Map<String, dynamic> json) => IncomeResult(
      result: Income.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IncomeResultToJson(IncomeResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

Income _$IncomeFromJson(Map<String, dynamic> json) => Income(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
      source: json['source'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$IncomeToJson(Income instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'value': instance.value,
      'source': instance.source,
      'timestamp': instance.timestamp.toIso8601String(),
      'currency': instance.currency,
    };

IncomeCreateBody _$IncomeCreateBodyFromJson(Map<String, dynamic> json) =>
    IncomeCreateBody(
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
      source: json['source'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      currencyId: (json['currencyId'] as num).toInt(),
    );

Map<String, dynamic> _$IncomeCreateBodyToJson(IncomeCreateBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'source': instance.source,
      'timestamp': instance.timestamp.toIso8601String(),
      'currencyId': instance.currencyId,
    };

IncomeUpdateBody _$IncomeUpdateBodyFromJson(Map<String, dynamic> json) =>
    IncomeUpdateBody(
      name: json['name'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      source: json['source'] as String?,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      currencyId: (json['currencyId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$IncomeUpdateBodyToJson(IncomeUpdateBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'source': instance.source,
      'timestamp': instance.timestamp?.toIso8601String(),
      'currencyId': instance.currencyId,
    };
