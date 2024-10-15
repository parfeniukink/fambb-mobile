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
  late List<Transaction> _transactions;

  Future<void> getTransactions() async {
    List<Transaction>? transactions =
        await ApiService().fetchTransactions(widget.currencyId);

    if (transactions != null) {
      setState(() {
        _transactions = transactions;
        _isLoading = false;
      });
    }
  }

  // Method to convert transaction into a displayable string
  String getTransactionRepr(Transaction transaction) {
    // Dispatcher for Operation Types
    switch (transaction.operation) {
      case "cost":
        return "- ${transaction.name} ${transaction.value.toStringAsFixed(2)}${transaction.currency}"
            .toString();
      case "income":
        return "+ ${transaction.name} ${transaction.value.toStringAsFixed(2)}${transaction.currency}"
            .toString();
      case "exchange":
        return "= Exchange ${transaction.value.toStringAsFixed(2)}${transaction.currency}"
            .toString();
      default:
        throw Error();
    }
  }

  Widget buildScreen() {
    return _isLoading
        ? const Center(
            child: CupertinoActivityIndicator(),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _transactions.map((item) {
              String text = getTransactionRepr(item);
              return Row(children: [Text(text)]);
            }).toList());
  }

  @override
  void initState() {
    super.initState();
    getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: buildScreen(),
        ),
      ),
    );
  }
}
