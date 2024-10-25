import 'dart:convert';
import 'dart:developer';

import 'package:fambb_mobile/data/exchange.dart';
import 'package:fambb_mobile/data/income.dart';
import 'package:http/http.dart' as http;
import 'package:fambb_mobile/data/equity.dart';
import 'package:fambb_mobile/data/transactions.dart';
import 'package:fambb_mobile/data/currency.dart';
import 'package:fambb_mobile/data/user.dart';
import 'package:fambb_mobile/data/cost.dart';

const String baseUrl = "http://localhost:8000";
const String usersPath = "/users";
const String currenciesPath = "/currencies";
const String costCategoriesPath = "/costs/categories";
const String costPath = "/costs";
const String analyticsEquityPath = "/analytics/equity";
const String analyticsTransactionsPath = "/analytics/transactions";

class ApiService {
  // Get all the equity data
  // -----------------------------------------
  Future<User?> fetchUser() async {
    try {
      var url = Uri.parse(baseUrl + usersPath);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var userResult = UserResults.fromJson(json.decode(response.body));
        return userResult.result;
      } else {
        log('Failed to load equity data');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // Get all the equity data
  // -----------------------------------------
  Future<List<Equity>?> fetchEquity() async {
    try {
      var url = Uri.parse(baseUrl + analyticsEquityPath);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var equityResults = EquityResults.fromJson(json.decode(response.body));
        return equityResults.result;
      } else {
        log('Failed to load equity data');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // Fetch currencies
  // -----------------------------------------
  Future<List<Currency>?> fetchCurrencies() async {
    try {
      var url = Uri.parse(baseUrl + currenciesPath);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var currencyResults =
            CurrencyResults.fromJson(json.decode(response.body));
        return currencyResults.result;
      } else {
        log('Failed to load currencies');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // Fetch cost categories
  // -----------------------------------------
  Future<List<CostCategory>?> fetchCostCategories() async {
    try {
      var url = Uri.parse(baseUrl + costCategoriesPath);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var costCategoryResults =
            CostCategoryResults.fromJson(json.decode(response.body));
        return costCategoryResults.result;
      } else {
        log('Failed to load cost categories');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // Get last 10 transactions
  // -----------------------------------------
  Future<TransactionResults?> fetchTransactions(
      {int? currency, int context = 0, int limit = 10}) async {
    try {
      Uri url;

      // Build the URL with optional currency and pagination parameters
      if (currency == null) {
        url = Uri.parse(
            "$baseUrl$analyticsTransactionsPath?context=$context&limit=$limit");
      } else {
        url = Uri.parse(
            "$baseUrl$analyticsTransactionsPath?currencyId=$currency&context=$context&limit=$limit");
      }

      var response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse the JSON response into the TransactionResults object
        TransactionResults transactionResults =
            TransactionResults.fromJson(json.decode(response.body));
        return transactionResults; // Return the full result with context and left
      } else {
        log("Failed to load transactions. Status code: ${response.statusCode}");
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // Add yet another cost.
  // Returns `true` if created
  // Returns `false` if not created
  Future<bool> addCost(CostCreateBody costCreateBody) async {
    try {
      var response = await http.post(
        Uri.parse(
          "$baseUrl$costPath",
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(costCreateBody.toJson()),
      );

      if (response.statusCode == 201) {
        log('Cost created successfully');
        return true; // Successfully created
      } else {
        log('Failed to create cost. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
    return false; // Failed to create
  }

  // Get existing cost.
  Future<Cost?> getCost(int costId) async {
    try {
      var response = await http.get(
        Uri.parse("$baseUrl$costPath/$costId"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        return CostResults.fromJson(json.decode(response.body)).result;
      } else {}
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // Update existing cost.
  // Returns `true` if updated
  // Returns `false` if not updated
  Future<bool> updateCost(int costId, CostUpdateBody costUpdateBody) async {
    try {
      var response = await http.patch(
        Uri.parse(
          "$baseUrl$costPath/$costId",
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(costUpdateBody.toJson()),
      );

      if (response.statusCode == 200) {
        return true; // Successfully updated
      } else {}
    } catch (e) {
      log(e.toString());
    }
    return false; // Failed to update
  }

  // Delete existing cost.
  // Returns `true` if deleted
  // Returns `false` if not deleted
  Future<bool> deleteCost(int costId) async {
    try {
      var response = await http.delete(
        Uri.parse(
          "$baseUrl$costPath/$costId",
        ),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 204) {
        return true; // Successfully updated
      } else {}
    } catch (e) {
      log(e.toString());
    }
    return false; // Failed to update
  }

  // Incomes section
  // -----------------------------------------
  Future<bool> addIncome(IncomeCreateBody body) async {
    try {
      var response = await http.post(
        Uri.parse(
          "$baseUrl/incomes",
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body.toJson()),
      );

      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  // Get existing income.
  Future<Income?> getIncome(int incomeId) async {
    try {
      var response = await http.get(
        Uri.parse("$baseUrl/incomes/$incomeId"),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        return IncomeResult.fromJson(json.decode(response.body)).result;
      } else {}
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // Update existing income.
  // Returns `true` if updated
  // Returns `false` if not updated
  Future<bool> updateIncome(int incomeId, IncomeUpdateBody body) async {
    try {
      var response = await http.patch(
        Uri.parse(
          "$baseUrl/incomes/$incomeId",
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body.toJson()),
      );

      if (response.statusCode == 200) {
        return true; // Successfully updated
      } else {}
    } catch (e) {
      log(e.toString());
    }
    return false; // Failed to update
  }

  // Delete existing income.
  // Returns `true` if deleted
  // Returns `false` if not deleted
  Future<bool> deleteIncome(int imcomeId) async {
    try {
      var response = await http.delete(
        Uri.parse(
          "$baseUrl/incomes/$imcomeId",
        ),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 204) {
        return true; // Successfully updated
      } else {}
    } catch (e) {
      log(e.toString());
    }
    return false; // Failed to update
  }

  // Currency exchange section
  // -----------------------------------------
  Future<bool> addExchange(ExchangeCreateBody body) async {
    try {
      var response = await http.post(
        Uri.parse(
          "$baseUrl/exchange",
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body.toJson()),
      );

      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  // Delete existing income.
  // Returns `true` if deleted
  // Returns `false` if not deleted
  Future<bool> deleteExchange(int exchangeId) async {
    try {
      var response = await http.delete(
        Uri.parse(
          "$baseUrl/exchange/$exchangeId",
        ),
        headers: {"Content-Type": "application/json"},
      );

      if (response.statusCode == 204) {
        return true;
      } else {}
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  // Cost Shortcuts section
  // -----------------------------------------

  // Add yet another cost.
  // Returns `true` if created
  // Returns `false` if not created
  Future<bool> addCostShortcut(CostShortcutCreateBody body) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/costs/shortcuts"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body.toJson()),
      );

      if (response.statusCode == 201) {
        log('Cost shortcut created successfully');
        return true; // Successfully created
      } else {
        log('Failed to create cost shortcut. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
    return false; // Failed to create
  }

  // Fetch all the cost shortcuts from the API
  Future<List<CostShortcut>?> fetchCostShortcuts() async {
    try {
      var url = Uri.parse("$baseUrl/costs/shortcuts");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var results = CostShortcutResults.fromJson(json.decode(response.body));
        return results.result;
      } else {
        log('Failed to load cost shortcuts');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // Apply selected cost shortcut
  // -----------------------------------------
  Future<bool> applyCostShortcut(int shortcutId, double? value) async {
    try {
      var response = await http.post(
        Uri.parse(
          "$baseUrl/costs/shortcuts/$shortcutId",
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"value": value}),
      );

      if (response.statusCode == 201) {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  // update user settings
  Future<bool> updateUserConfiguration(UserConfigurationUpdateBody body) async {
    try {
      var response = await http.put(
        Uri.parse(
          "$baseUrl/users/configuration",
        ),
        headers: {"Content-Type": "application/json"},
        body: json.encode(body.toJson()),
      );

      if (response.statusCode == 200) {
        return true; // Successfully updated
      } else {}
    } catch (e) {
      log(e.toString());
    }
    return false; // Failed to update
  }
}
