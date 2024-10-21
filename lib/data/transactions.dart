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
  final int id; // identifier of the cost|income|exchange
  final String operation; // cost, income, exchange
  final String name;
  final double value;
  final String timestamp;
  final String currency;

  Transaction({
    required this.id,
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
