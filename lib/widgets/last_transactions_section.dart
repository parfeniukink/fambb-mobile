import 'package:flutter/cupertino.dart';
import 'package:fambb_mobile/data/transactions.dart';

class LastTransactionsSection extends StatelessWidget {
  final List<Transaction> transactions;

  const LastTransactionsSection({super.key, required this.transactions});

  String getTransactionRepr(Transaction transaction) {
    // Dispatcher for Operation Types
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

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Center(child: Text("no transactions"));
    } else {
      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: transactions.map((item) {
            String text = getTransactionRepr(item);
            return Row(children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(text),
                ),
              ),
            ]);
          }).toList());
    }
  }
}
