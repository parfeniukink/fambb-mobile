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

UserConfigurationUpdateBody _$UserConfigurationUpdateBodyFromJson(
        Map<String, dynamic> json) =>
    UserConfigurationUpdateBody(
      defaultCurrencyId: (json['defaultCurrencyId'] as num?)?.toInt(),
      defaultCostCategoryId: (json['defaultCostCategoryId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserConfigurationUpdateBodyToJson(
        UserConfigurationUpdateBody instance) =>
    <String, dynamic>{
      'defaultCurrencyId': instance.defaultCurrencyId,
      'defaultCostCategoryId': instance.defaultCostCategoryId,
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
    );

Map<String, dynamic> _$UserConfigurationToJson(UserConfiguration instance) =>
    <String, dynamic>{
      'defaultCurrency': instance.defaultCurrency,
      'defaultCostCategory': instance.defaultCostCategory,
    };
