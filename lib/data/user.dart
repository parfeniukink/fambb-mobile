import 'package:json_annotation/json_annotation.dart';

import 'currency.dart';
import 'transactions.dart';

part 'user.g.dart';

@JsonSerializable()
class UserResults {
  final User result;

  UserResults({
    required this.result,
  });

  factory UserResults.fromJson(Map<String, dynamic> json) =>
      _$UserResultsFromJson(json);
  Map<String, dynamic> toJson() => _$UserResultsToJson(this);
}

@JsonSerializable()
class User {
  final int id;
  final String name;
  final UserConfiguration configuration;

  User({
    required this.id,
    required this.name,
    required this.configuration,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class UserConfiguration {
  final Currency? defaultCurrency;
  final CostCategory? defaultCostCategory;
  final List<String>? commonCosts;
  final List<String>? commonIncomes;

  UserConfiguration({
    this.defaultCurrency,
    this.defaultCostCategory,
    this.commonCosts,
    this.commonIncomes,
  });

  factory UserConfiguration.fromJson(Map<String, dynamic> json) =>
      _$UserConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$UserConfigurationToJson(this);
}
