// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResults _$UserResultsFromJson(Map<String, dynamic> json) => UserResults(
      result: User.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResultsToJson(UserResults instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      configuration: UserConfiguration.fromJson(
          json['configuration'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'configuration': instance.configuration,
    };

UserConfiguration _$UserConfigurationFromJson(Map<String, dynamic> json) =>
    UserConfiguration(
      defaultCurrency: json['defaultCurrency'] == null
          ? null
          : Currency.fromJson(json['defaultCurrency'] as Map<String, dynamic>),
      defaultCostCategory: json['defaultCostCategory'] == null
          ? null
          : CostCategory.fromJson(
              json['defaultCostCategory'] as Map<String, dynamic>),
      commonCosts: (json['commonCosts'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      commonIncomes: (json['commonIncomes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UserConfigurationToJson(UserConfiguration instance) =>
    <String, dynamic>{
      'defaultCurrency': instance.defaultCurrency,
      'defaultCostCategory': instance.defaultCostCategory,
      'commonCosts': instance.commonCosts,
      'commonIncomes': instance.commonIncomes,
    };
