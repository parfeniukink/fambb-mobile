import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:fambb_mobile/data/equity.dart';
import 'package:fambb_mobile/data/transactions.dart';

const String baseUrl = "http://localhost:8000";
const String equityPath = "/analytics/equity";
const String transactionsPath = "/analytics/transactions";
const String lastTransactionsPath = "/analytics/transactions/last";

class ApiService {
  // Get all the equity data
  // -----------------------------------------
  Future<List<Equity>?> fetchEquity() async {
    try {
      var url = Uri.parse(baseUrl + equityPath);
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

  // Get last transactions
  // -----------------------------------------
  Future<List<Transaction>?> fetchTransactions([int? currency]) async {
    try {
      Uri url;

      if (currency == null) {
        url = Uri.parse("$baseUrl$lastTransactionsPath");
      } else {
        url = Uri.parse("$baseUrl$transactionsPath?currency=$currency");
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
