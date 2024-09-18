// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'equity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EquityResults _$EquityResultsFromJson(Map<String, dynamic> json) =>
    EquityResults(
      result: (json['result'] as List<dynamic>)
          .map((e) => Equity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EquityResultsToJson(EquityResults instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

Equity _$EquityFromJson(Map<String, dynamic> json) => Equity(
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
      amount: (json['amount'] as num).toInt(),
    );

Map<String, dynamic> _$EquityToJson(Equity instance) => <String, dynamic>{
      'currency': instance.currency,
      'amount': instance.amount,
    };
