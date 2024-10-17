import 'dart:convert';
import 'dart:developer';

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
}
