import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:fambb_mobile/data/exchange.dart';
import 'package:fambb_mobile/data/income.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:fambb_mobile/data/equity.dart';
import 'package:fambb_mobile/data/transactions.dart';
import 'package:fambb_mobile/data/currency.dart';
import 'package:fambb_mobile/data/user.dart';
import 'package:fambb_mobile/data/analytics.dart';
import 'package:fambb_mobile/data/cost.dart';

const String usersPath = "/users";
const String currenciesPath = "/currencies";
const String costCategoriesPath = "/costs/categories";
const String costPath = "/costs";
const String analyticsEquityPath = "/analytics/equity";
const String analyticsTransactionsPath = "/analytics/transactions";

class ApiService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String baseUrl = dotenv.env['API_BASE_URL']!;

  Future<Map<String, String>> _getHeaders() async {
    final secret = await _storage.read(key: 'userSecret');
    if (secret == null) {
      throw Error();
    }

    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $secret"
    };
  }

  Map<String, dynamic> decodeJson(http.Response response) {
    return json.decode(utf8.decode(response.bodyBytes));
  }

  // Get all the equity data
  // -----------------------------------------
  Future<User?> fetchUser() async {
    try {
      var url = Uri.parse(baseUrl + usersPath);
      var response = await http.get(url, headers: await _getHeaders());

      if (response.statusCode == 200) {
        var userResult = UserResults.fromJson(decodeJson(response));
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
      var response = await http.get(url, headers: await _getHeaders());

      if (response.statusCode == 200) {
        var equityResults = EquityResults.fromJson(decodeJson(response));
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
      var response = await http.get(url, headers: await _getHeaders());

      if (response.statusCode == 200) {
        var currencyResults = CurrencyResults.fromJson(decodeJson(response));
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
      http.Response response =
          await http.get(url, headers: await _getHeaders());

      if (response.statusCode == 200) {
        var costCategoryResults =
            CostCategoryResults.fromJson(decodeJson(response));
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

      var response = await http.get(url, headers: await _getHeaders());

      if (response.statusCode == 200) {
        // Parse the JSON response into the TransactionResults object
        TransactionResults transactionResults =
            TransactionResults.fromJson(decodeJson(response));
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
        headers: await _getHeaders(),
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
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        return CostResults.fromJson(decodeJson(response)).result;
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
        headers: await _getHeaders(),
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
        headers: await _getHeaders(),
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
        headers: await _getHeaders(),
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
        headers: await _getHeaders(),
      );

      if (response.statusCode == 200) {
        return IncomeResult.fromJson(decodeJson(response)).result;
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
        headers: await _getHeaders(),
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
        headers: await _getHeaders(),
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
        headers: await _getHeaders(),
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
        headers: await _getHeaders(),
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
        headers: await _getHeaders(),
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
      var response = await http.get(url, headers: await _getHeaders());

      if (response.statusCode == 200) {
        var results = CostShortcutResults.fromJson(decodeJson(response));
        return results.result;
      } else {
        log('Failed to load cost shortcuts');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  // Delete shortcut by its id
  Future<bool> deleteCostShortcut(int shortcutId) async {
    try {
      var response = await http.delete(
        Uri.parse("$baseUrl/costs/shortcuts/$shortcutId"),
        headers: await _getHeaders(),
      );

      if (response.statusCode == 204) {
        log('Cost shortcut deleted successfully');
        return true;
      } else {
        log('Failed to delete cost shortcut. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  // Apply selected cost shortcut
  // -----------------------------------------
  Future<bool> applyCostShortcut(int shortcutId, double? value) async {
    try {
      var response = await http.post(
        Uri.parse(
          "$baseUrl/costs/shortcuts/$shortcutId",
        ),
        headers: await _getHeaders(),
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

  // Update user settings
  Future<bool> updateUserConfiguration(UserConfigurationUpdateBody body) async {
    try {
      var response = await http.put(
        Uri.parse(
          "$baseUrl/users/configuration",
        ),
        headers: await _getHeaders(),
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

  // Basic analytics
  Future<List<Analytics>?> fetchBasicAnalytics(String period) async {
    try {
      var url = Uri.parse("$baseUrl/analytics/basic?period=$period");
      var response = await http.get(url, headers: await _getHeaders());

      if (response.statusCode == 200) {
        var results = AnalyticsResponse.fromJson(decodeJson(response));
        return results.result;
      } else {
        log('Failed to load basic analytics');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Analytics>?> fetchBasicAnalyticsByRange(
      DateTime start, DateTime end) async {
    try {
      final DateFormat formatter = DateFormat('yyyy-MM-dd');
      String startDate = formatter.format(start);
      String endDate = formatter.format(end);

      var url = Uri.parse(
          "$baseUrl/analytics/basic?startDate=$startDate&endDate=$endDate");
      var response = await http.get(url, headers: await _getHeaders());

      if (response.statusCode == 200) {
        var results = AnalyticsResponse.fromJson(decodeJson(response));
        return results.result;
      } else {
        log('Failed to load basic analytics');
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
