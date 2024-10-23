import 'package:json_annotation/json_annotation.dart';

import 'currency.dart';

part 'cost.g.dart';

@JsonSerializable()
class CostCategoryResults {
  final List<CostCategory> result;

  CostCategoryResults({
    required this.result,
  });

  factory CostCategoryResults.fromJson(Map<String, dynamic> json) =>
      _$CostCategoryResultsFromJson(json);
  Map<String, dynamic> toJson() => _$CostCategoryResultsToJson(this);
}

@JsonSerializable()
class CostCategory {
  final int id;
  final String name;

  CostCategory({
    required this.id,
    required this.name,
  });

  factory CostCategory.fromJson(Map<String, dynamic> json) =>
      _$CostCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CostCategoryToJson(this);
}

@JsonSerializable()
class CostResults {
  final Cost result;

  CostResults({
    required this.result,
  });

  factory CostResults.fromJson(Map<String, dynamic> json) =>
      _$CostResultsFromJson(json);
  Map<String, dynamic> toJson() => _$CostResultsToJson(this);
}

@JsonSerializable()
class Cost {
  final int id;
  final String name;
  final double value;
  final DateTime timestamp;
  final Currency currency;
  final CostCategory category;

  Cost({
    required this.id,
    required this.name,
    required this.value,
    required this.timestamp,
    required this.currency,
    required this.category,
  });

  factory Cost.fromJson(Map<String, dynamic> json) => _$CostFromJson(json);
  Map<String, dynamic> toJson() => _$CostToJson(this);
}

@JsonSerializable()
class CostCreateBody {
  final String name;
  final double value;
  final DateTime timestamp;
  final int currencyId;
  final int categoryId;

  CostCreateBody({
    required this.name,
    required this.value,
    required this.timestamp,
    required this.currencyId,
    required this.categoryId,
  });

  factory CostCreateBody.fromJson(Map<String, dynamic> json) =>
      _$CostCreateBodyFromJson(json);
  Map<String, dynamic> toJson() => _$CostCreateBodyToJson(this);
}

@JsonSerializable()
class CostUpdateBody {
  final String? name;
  final double? value;
  final DateTime? timestamp;
  final int? currencyId;
  final int? categoryId;

  CostUpdateBody({
    this.name,
    this.value,
    this.timestamp,
    this.currencyId,
    this.categoryId,
  });

  factory CostUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$CostUpdateBodyFromJson(json);
  Map<String, dynamic> toJson() => _$CostUpdateBodyToJson(this);
}

@JsonSerializable()
class CostShortcutCreateBody {
  final String name;
  final double? value;
  final int currencyId;
  final int categoryId;

  CostShortcutCreateBody({
    required this.name,
    required this.value,
    required this.currencyId,
    required this.categoryId,
  });

  factory CostShortcutCreateBody.fromJson(Map<String, dynamic> json) =>
      _$CostShortcutCreateBodyFromJson(json);
  Map<String, dynamic> toJson() => _$CostShortcutCreateBodyToJson(this);
}

@JsonSerializable()
class CostShortcut {
  final int id;
  final String name;
  final double? value;
  final Currency currency;
  final CostCategory category;

  CostShortcut({
    required this.id,
    required this.name,
    required this.value,
    required this.currency,
    required this.category,
  });

  factory CostShortcut.fromJson(Map<String, dynamic> json) =>
      _$CostShortcutFromJson(json);
  Map<String, dynamic> toJson() => _$CostShortcutToJson(this);
}

@JsonSerializable()
class CostShortcutResults {
  final List<CostShortcut> result;

  CostShortcutResults({
    required this.result,
  });

  factory CostShortcutResults.fromJson(Map<String, dynamic> json) =>
      _$CostShortcutResultsFromJson(json);
  Map<String, dynamic> toJson() => _$CostShortcutResultsToJson(this);
}
