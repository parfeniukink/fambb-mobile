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
      id: (json['id'] as num).toInt(),
      operation: json['operation'] as String,
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
      timestamp: json['timestamp'] as String,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'operation': instance.operation,
      'name': instance.name,
      'value': instance.value,
      'timestamp': instance.timestamp,
      'currency': instance.currency,
    };
