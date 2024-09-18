// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finances.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
