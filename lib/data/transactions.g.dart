// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionResults _$TransactionResultsFromJson(Map<String, dynamic> json) =>
    TransactionResults(
      result: (json['result'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionResultsToJson(TransactionResults instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      name: json['name'] as String,
      value: (json['value'] as num).toInt(),
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
      operation: json['operation'] as String,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'currency': instance.currency,
      'operation': instance.operation,
    };

CostCategoryResults _$CostCategoryResultsFromJson(Map<String, dynamic> json) =>
    CostCategoryResults(
      result: (json['result'] as List<dynamic>)
          .map((e) => CostCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CostCategoryResultsToJson(
        CostCategoryResults instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

CostCategory _$CostCategoryFromJson(Map<String, dynamic> json) => CostCategory(
      name: json['name'] as String,
      value: (json['value'] as num).toInt(),
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
      operation: json['operation'] as String,
    );

Map<String, dynamic> _$CostCategoryToJson(CostCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'currency': instance.currency,
      'operation': instance.operation,
    };
