import 'package:json_annotation/json_annotation.dart';

part 'transactions.g.dart';

@JsonSerializable()
class TransactionResults {
  final List<Transaction> result;
  final int left;
  final int context;

  TransactionResults({
    required this.result,
    required this.left,
    required this.context,
  });

  factory TransactionResults.fromJson(Map<String, dynamic> json) =>
      _$TransactionResultsFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionResultsToJson(this);
}

@JsonSerializable()
class Transaction {
  final String operation; // income, cost, exchange
  final String name;
  final double value;
  final String timestamp;
  final String currency;

  Transaction({
    required this.operation,
    required this.name,
    required this.value,
    required this.timestamp,
    required this.currency,
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
