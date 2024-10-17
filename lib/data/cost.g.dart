// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CostCreateBody _$CostCreateBodyFromJson(Map<String, dynamic> json) =>
    CostCreateBody(
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      currencyId: (json['currencyId'] as num).toInt(),
      categoryId: (json['categoryId'] as num).toInt(),
    );

Map<String, dynamic> _$CostCreateBodyToJson(CostCreateBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'timestamp': instance.timestamp.toIso8601String(),
      'currencyId': instance.currencyId,
      'categoryId': instance.categoryId,
    };
