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
      left: (json['left'] as num).toInt(),
      context: (json['context'] as num).toInt(),
    );

Map<String, dynamic> _$TransactionResultsToJson(TransactionResults instance) =>
    <String, dynamic>{
      'result': instance.result,
      'left': instance.left,
      'context': instance.context,
    };

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      operation: json['operation'] as String,
      name: json['name'] as String,
      value: (json['value'] as num).toInt(),
      timestamp: json['timestamp'] as String,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'operation': instance.operation,
      'name': instance.name,
      'value': instance.value,
      'timestamp': instance.timestamp,
      'currency': instance.currency,
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
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
    );

Map<String, dynamic> _$CostCategoryToJson(CostCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
