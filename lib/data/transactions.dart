import 'package:json_annotation/json_annotation.dart';

import 'finances.dart';

part 'transactions.g.dart';

@JsonSerializable()
class TransactionResults {
  final List<Transaction> result;

  TransactionResults({
    required this.result,
  });

  factory TransactionResults.fromJson(Map<String, dynamic> json) =>
      _$TransactionResultsFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionResultsToJson(this);
}

@JsonSerializable()
class Transaction {
  final String name;
  final int value;
  final Currency currency;
  final String operation; // income, cost, exchange

  Transaction({
    required this.name,
    required this.value,
    required this.currency,
    required this.operation,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

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
  final String name;
  final int value;
  final Currency currency;
  final String operation; // income, cost, exchange

  CostCategory({
    required this.name,
    required this.value,
    required this.currency,
    required this.operation,
  });

  factory CostCategory.fromJson(Map<String, dynamic> json) =>
      _$CostCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$CostCategoryToJson(this);
}
