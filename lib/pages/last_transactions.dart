import 'package:fambb_mobile/data/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:fambb_mobile/data/transactions.dart';

class LastTransactionsPage extends StatefulWidget {
  final int currencyId;
  const LastTransactionsPage({super.key, required this.currencyId});

  @override
  State<LastTransactionsPage> createState() => _LastTransactionsPageState();
}

class _LastTransactionsPageState extends State<LastTransactionsPage> {
  late bool _isLoading = true;
  late bool _isLoadingMore = false; // Flag for loading more data
  late List<Transaction> _transactions = []; // Store transactions

  late int _context = 0; // Pagination context (offset)
  late int _left = 0; // Remaining items count

  // Fetch transactions with pagination support
  Future<void> getTransactions({bool loadMore = false}) async {
    if (loadMore) {
      setState(() {
        _isLoadingMore = true;
      });
    } else {
      setState(() {
        _isLoading = true;
      });
    }

    TransactionResults? result = await ApiService().fetchTransactions(
        currency: widget.currencyId, context: _context, limit: 10);

    if (result != null && result.result.isNotEmpty) {
      setState(() {
        if (loadMore) {
          _transactions.addAll(result.result); // Append new transactions
        } else {
          _transactions = result.result; // Load first batch of transactions
        }
        // Update context and left values
        _context = result.context; // Update context for next batch
        _left = result.left; // Remaining transactions
        _isLoading = false;
        _isLoadingMore = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        _isLoadingMore = false;
      });
    }
  }

  // Method to convert transaction into a displayable string
  String getTransactionRepr(Transaction transaction) {
    switch (transaction.operation) {
      case "cost":
        return "- ${transaction.name} ${transaction.value.toStringAsFixed(2)}${transaction.currency}";
      case "income":
        return "+ ${transaction.name} ${transaction.value.toStringAsFixed(2)}${transaction.currency}";
      case "exchange":
        return "≈ Exchange ${transaction.value.toStringAsFixed(2)}${transaction.currency}";
      default:
        throw Error();
    }
  }

  // Build the main content of the screen
  Widget buildScreen() {
    return ListView(
      children: [
        // Display the transactions
        ..._transactions.map((item) {
          String text = getTransactionRepr(item);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(text),
                  ),
                ),
              ],
            ),
          );
        }).toList(),

        // Show 'Load More' button if there are more items to load
        if (_left > 0)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CupertinoButton(
              onPressed:
                  _isLoadingMore ? null : () => getTransactions(loadMore: true),
              child: _isLoadingMore
                  ? const CupertinoActivityIndicator()
                  : const Text("Load More"),
            ),
          ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getTransactions(); // Load initial batch of transactions
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: _isLoading
              ? const Center(child: CupertinoActivityIndicator())
              : buildScreen(),
        ),
      ),
    );
  }
}
