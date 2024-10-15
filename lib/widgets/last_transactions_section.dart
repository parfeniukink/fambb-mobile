import 'package:fambb_mobile/data/api.dart';
import 'package:flutter/cupertino.dart';
import 'package:fambb_mobile/data/transactions.dart';

class LastTransactionsSection extends StatefulWidget {
  const LastTransactionsSection({super.key});

  @override
  State<LastTransactionsSection> createState() =>
      _LastTransactionsSectionState();
}

class _LastTransactionsSectionState extends State<LastTransactionsSection> {
  late bool _isLoading = true;
  late List<Transaction> _transactions;

  Future<void> getLastTransactions() async {
    List<Transaction>? transactions = await ApiService().fetchTransactions();

    if (transactions != null) {
      setState(() {
        _transactions = transactions;
        _isLoading = false;
      });
    }
  }

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

  @override
  void initState() {
    super.initState();
    getLastTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CupertinoActivityIndicator(),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: _transactions.map((item) {
              String text = getTransactionRepr(item);
              return Row(children: [
                Expanded(
                    child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                )),
              ]);
            }).toList());
  }
}
