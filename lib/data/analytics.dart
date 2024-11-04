import 'package:json_annotation/json_annotation.dart';

import 'currency.dart';

part 'analytics.g.dart';

@JsonSerializable()
class AnalyticsResponse {
  final List<Analytics> result;

  AnalyticsResponse({required this.result});

  factory AnalyticsResponse.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AnalyticsResponseToJson(this);
}

@JsonSerializable()
class Analytics {
  final Currency currency;
  final AnalyticsCosts costs;
  final AnalyticsIncomes incomes;
  final double fromExchanges;
  final double totalRatio;

  Analytics({
    required this.currency,
    required this.costs,
    required this.incomes,
    required this.fromExchanges,
    required this.totalRatio,
  });

  factory Analytics.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsFromJson(json);
  Map<String, dynamic> toJson() => _$AnalyticsToJson(this);
}

@JsonSerializable()
class AnalyticsCosts {
  final double total;
  final List<AnalyticsCategory> categories;

  AnalyticsCosts({required this.total, required this.categories});

  factory AnalyticsCosts.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsCostsFromJson(json);
  Map<String, dynamic> toJson() => _$AnalyticsCostsToJson(this);
}

@JsonSerializable()
class AnalyticsCategory {
  final String name;
  final double total;
  final double ratio;

  AnalyticsCategory({
    required this.name,
    required this.total,
    required this.ratio,
  });

  factory AnalyticsCategory.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$AnalyticsCategoryToJson(this);
}

@JsonSerializable()
class AnalyticsIncomes {
  final double total;
  final List<IncomeSource> sources;

  AnalyticsIncomes({required this.total, required this.sources});

  factory AnalyticsIncomes.fromJson(Map<String, dynamic> json) =>
      _$AnalyticsIncomesFromJson(json);
  Map<String, dynamic> toJson() => _$AnalyticsIncomesToJson(this);
}

@JsonSerializable()
class IncomeSource {
  final String source;
  final double total;

  IncomeSource({required this.source, required this.total});

  factory IncomeSource.fromJson(Map<String, dynamic> json) =>
      _$IncomeSourceFromJson(json);
  Map<String, dynamic> toJson() => _$IncomeSourceToJson(this);
}
