import 'package:fambb_mobile/data/api.dart';
import 'package:fambb_mobile/data/currency.dart';
import 'package:fambb_mobile/data/cost.dart';
import 'package:fambb_mobile/data/user.dart';
import 'package:fambb_mobile/pages/update_cost.dart';
import 'package:fambb_mobile/pages/update_income.dart';
import 'package:flutter/cupertino.dart';
import 'package:fambb_mobile/data/transactions.dart';

class LastTransactionsPage extends StatefulWidget {
  final int currencyId;
  final User user;
  final List<Currency> currencies;
  final List<CostCategory> costCategories;

  const LastTransactionsPage({
    super.key,
    required this.currencyId,
    required this.user,
    required this.currencies,
    required this.costCategories,
  });

  @override
  State<LastTransactionsPage> createState() => _LastTransactionsPageState();
}

class _LastTransactionsPageState extends State<LastTransactionsPage> {
  // Page utils
  late bool _isLoading = true;

  // Pagination data
  late bool _hasMoreTransaction = false;
  late int _context = 0;
  late int _left = 0;

  // User data
  late List<Transaction> _transactions = [];

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

  // Build the main content of the screen
  Widget buildScreen() {
    // Group transactions by timestamp
    Map<String, List<Transaction>> groupedTransactions = {};
    for (var transaction in _transactions) {
      if (groupedTransactions[transaction.timestamp] == null) {
        groupedTransactions[transaction.timestamp] = [];
      }
      groupedTransactions[transaction.timestamp]!.add(transaction);
    }

    List<Widget> transactionWidgets = [];
    groupedTransactions.forEach((timestamp, transactions) {
      transactionWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            timestamp,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      );

      for (var transaction in transactions) {
        String text = getTransactionRepr(transaction);

        transactionWidgets.add(
          GestureDetector(
            onLongPress: () => showTransactionActions(
                context, transaction), // Long press triggers action menu
            child: Padding(
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
            ),
          ),
        );
      }

      // Add spacing between groups
      transactionWidgets.add(const SizedBox(height: 20));
    });

    // Show 'Load More' button if there are more items to load
    if (_left > 0) {
      transactionWidgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: CupertinoButton(
            onPressed: _hasMoreTransaction
                ? null
                : () => getTransactions(loadMore: true),
            child: _hasMoreTransaction
                ? const CupertinoActivityIndicator()
                : const Text("load more"),
          ),
        ),
      );
    }

    return ListView(children: transactionWidgets);
  }

// Fetch transactions with pagination support
  Future<void> getTransactions({bool loadMore = false}) async {
    if (!mounted) return;

    if (loadMore) {
      setState(() {
        _hasMoreTransaction = true;
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
          _transactions.addAll(result.result);
        } else {
          _transactions = result.result;
        }
        _context = result.context;
        _left = result.left;
        _isLoading = false;
        _hasMoreTransaction = false;
      });
    } else {
      setState(() {
        _isLoading = false;
        _hasMoreTransaction = false;
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

  Future<Map?> showTransactionActions(
      BuildContext context, Transaction transaction) async {
    return showCupertinoModalPopup<Map>(
      context: context,
      builder: (BuildContext context) {
        List<Widget> actions = [
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            child: const Text("delete"),
            onPressed: () {
              Navigator.pop(context);
              deleteCallback(transaction);
            },
          ),
        ];

        if (transaction.operation == "cost" ||
            transaction.operation == "income") {
          actions.add(CupertinoActionSheetAction(
            child: const Text("edit"),
            onPressed: () {
              Navigator.pop(context);
              editCallback(transaction);
            },
          ));
        }

        return CupertinoActionSheet(
          title: const Text('select an option'),
          actions: actions,
        );
      },
    );
  }

  // Update the transaction depending on the operation
  Future<void> editCallback(Transaction transaction) async {
    if (transaction.operation == "cost") {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => UpdateCostPage(
            transaction: transaction,
            user: widget.user,
            currencies: widget.currencies,
            costCategories: widget.costCategories,
          ),
        ),
      );
    } else if (transaction.operation == "income") {
      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => UpdateIncomePage(
            transaction: transaction,
            user: widget.user,
            currencies: widget.currencies,
          ),
        ),
      );
    } else {
      throw Error();
    }
  }

  // Delete the transaction depending on the operation
  Future<void> deleteCallback(Transaction transaction) async {
    ApiService api = ApiService();

    setState(() {
      _transactions.removeWhere((t) => t.id == transaction.id);
    });

    Navigator.pop(context);

    if (transaction.operation == "cost") {
      await api.deleteCost(transaction.id);
    } else if (transaction.operation == "income") {
      await api.deleteIncome(transaction.id);
    } else if (transaction.operation == "exchange") {
      await api.deleteExchange(transaction.id);
    } else {
      throw Error();
    }
  }
}
