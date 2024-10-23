// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cost.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

CostResults _$CostResultsFromJson(Map<String, dynamic> json) => CostResults(
      result: Cost.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CostResultsToJson(CostResults instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

Cost _$CostFromJson(Map<String, dynamic> json) => Cost(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      value: (json['value'] as num).toDouble(),
      timestamp: DateTime.parse(json['timestamp'] as String),
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
      category: CostCategory.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CostToJson(Cost instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'value': instance.value,
      'timestamp': instance.timestamp.toIso8601String(),
      'currency': instance.currency,
      'category': instance.category,
    };

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

CostUpdateBody _$CostUpdateBodyFromJson(Map<String, dynamic> json) =>
    CostUpdateBody(
      name: json['name'] as String?,
      value: (json['value'] as num?)?.toDouble(),
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      currencyId: (json['currencyId'] as num?)?.toInt(),
      categoryId: (json['categoryId'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CostUpdateBodyToJson(CostUpdateBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'timestamp': instance.timestamp?.toIso8601String(),
      'currencyId': instance.currencyId,
      'categoryId': instance.categoryId,
    };

CostShortcutCreateBody _$CostShortcutCreateBodyFromJson(
        Map<String, dynamic> json) =>
    CostShortcutCreateBody(
      name: json['name'] as String,
      value: (json['value'] as num?)?.toDouble(),
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
      category: CostCategory.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CostShortcutCreateBodyToJson(
        CostShortcutCreateBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'currency': instance.currency,
      'category': instance.category,
    };

CostShortcut _$CostShortcutFromJson(Map<String, dynamic> json) => CostShortcut(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      value: (json['value'] as num?)?.toDouble(),
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
      category: CostCategory.fromJson(json['category'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CostShortcutToJson(CostShortcut instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'value': instance.value,
      'currency': instance.currency,
      'category': instance.category,
    };

CostShortcutResults _$CostShortcutResultsFromJson(Map<String, dynamic> json) =>
    CostShortcutResults(
      result: (json['result'] as List<dynamic>)
          .map((e) => CostShortcut.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CostShortcutResultsToJson(
        CostShortcutResults instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
