// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurrencyResults _$CurrencyResultsFromJson(Map<String, dynamic> json) =>
    CurrencyResults(
      result: (json['result'] as List<dynamic>)
          .map((e) => Currency.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CurrencyResultsToJson(CurrencyResults instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

Currency _$CurrencyFromJson(Map<String, dynamic> json) => Currency(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      sign: json['sign'] as String,
    );

Map<String, dynamic> _$CurrencyToJson(Currency instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'sign': instance.sign,
    };
