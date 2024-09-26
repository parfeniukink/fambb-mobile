import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:fambb_mobile/data/equity.dart';
import 'package:fambb_mobile/data/transactions.dart';
import 'package:fambb_mobile/data/currency.dart';
import 'package:fambb_mobile/data/user.dart';

const String baseUrl = "http://localhost:8000";
const String usersPath = "/users";
const String currenciesPath = "/currencies";
const String costCategoriesPath = "/costs/categories";
const String costPath = "/costs";
const String analyticsEquityPath = "/analytics/equity";
const String analyticsTransactionsPath = "/analytics/transactions";
const String analyticsLastTransactionsPath = "/analytics/transactions/last";

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

  // Get last transactions
  // -----------------------------------------
  Future<List<Transaction>?> fetchTransactions([int? currency]) async {
    try {
      Uri url;

      if (currency == null) {
        url = Uri.parse("$baseUrl$analyticsLastTransactionsPath");
      } else {
        url =
            Uri.parse("$baseUrl$analyticsTransactionsPath?currency=$currency");
      }
      var response = await http.get(url);

      if (response.statusCode == 200) {
        TransactionResults transactionResults =
            TransactionResults.fromJson(json.decode(response.body));
        return transactionResults.result;
      } else {
        log("Failed to load transactions");
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
