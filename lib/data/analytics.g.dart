// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'analytics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnalyticsResponse _$AnalyticsResponseFromJson(Map<String, dynamic> json) =>
    AnalyticsResponse(
      result: (json['result'] as List<dynamic>)
          .map((e) => Analytics.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnalyticsResponseToJson(AnalyticsResponse instance) =>
    <String, dynamic>{
      'result': instance.result,
    };

Analytics _$AnalyticsFromJson(Map<String, dynamic> json) => Analytics(
      currency: Currency.fromJson(json['currency'] as Map<String, dynamic>),
      costs: AnalyticsCosts.fromJson(json['costs'] as Map<String, dynamic>),
      incomes:
          AnalyticsIncomes.fromJson(json['incomes'] as Map<String, dynamic>),
      fromExchanges: (json['fromExchanges'] as num).toDouble(),
      totalRatio: (json['totalRatio'] as num).toDouble(),
    );

Map<String, dynamic> _$AnalyticsToJson(Analytics instance) => <String, dynamic>{
      'currency': instance.currency,
      'costs': instance.costs,
      'incomes': instance.incomes,
      'fromExchanges': instance.fromExchanges,
      'totalRatio': instance.totalRatio,
    };

AnalyticsCosts _$AnalyticsCostsFromJson(Map<String, dynamic> json) =>
    AnalyticsCosts(
      total: (json['total'] as num).toDouble(),
      categories: (json['categories'] as List<dynamic>)
          .map((e) => AnalyticsCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnalyticsCostsToJson(AnalyticsCosts instance) =>
    <String, dynamic>{
      'total': instance.total,
      'categories': instance.categories,
    };

AnalyticsCategory _$AnalyticsCategoryFromJson(Map<String, dynamic> json) =>
    AnalyticsCategory(
      name: json['name'] as String,
      total: (json['total'] as num).toDouble(),
      ratio: (json['ratio'] as num).toDouble(),
    );

Map<String, dynamic> _$AnalyticsCategoryToJson(AnalyticsCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'total': instance.total,
      'ratio': instance.ratio,
    };

AnalyticsIncomes _$AnalyticsIncomesFromJson(Map<String, dynamic> json) =>
    AnalyticsIncomes(
      total: (json['total'] as num).toDouble(),
      sources: (json['sources'] as List<dynamic>)
          .map((e) => IncomeSource.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AnalyticsIncomesToJson(AnalyticsIncomes instance) =>
    <String, dynamic>{
      'total': instance.total,
      'sources': instance.sources,
    };

IncomeSource _$IncomeSourceFromJson(Map<String, dynamic> json) => IncomeSource(
      source: json['source'] as String,
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$IncomeSourceToJson(IncomeSource instance) =>
    <String, dynamic>{
      'source': instance.source,
      'total': instance.total,
    };
