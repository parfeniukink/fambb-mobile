import 'package:json_annotation/json_annotation.dart';

import 'currency.dart';
import 'cost.dart';

part 'user.g.dart';

// API user response
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

// public user representation
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

// update the user configuration HTTP request body
@JsonSerializable()
class UserConfigurationUpdateBody {
  int? defaultCurrencyId;
  int? defaultCostCategoryId;

  UserConfigurationUpdateBody({
    this.defaultCurrencyId,
    this.defaultCostCategoryId,
  });
  factory UserConfigurationUpdateBody.fromJson(Map<String, dynamic> json) =>
      _$UserConfigurationUpdateBodyFromJson(json);
  Map<String, dynamic> toJson() => _$UserConfigurationUpdateBodyToJson(this);
}

// public user configuration representation
@JsonSerializable()
class UserConfiguration {
  final Currency? defaultCurrency;
  final CostCategory? defaultCostCategory;

  UserConfiguration({
    this.defaultCurrency,
    this.defaultCostCategory,
  });

  factory UserConfiguration.fromJson(Map<String, dynamic> json) =>
      _$UserConfigurationFromJson(json);
  Map<String, dynamic> toJson() => _$UserConfigurationToJson(this);
}
