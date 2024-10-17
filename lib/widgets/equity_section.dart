import 'package:fambb_mobile/pages/last_transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:fambb_mobile/data/equity.dart';

import 'package:fambb_mobile/data/currency.dart';

class EquitySection extends StatelessWidget {
  final List<Equity> equityData;

  const EquitySection({super.key, required this.equityData});

  _goLastTransactions(BuildContext context, Currency currency) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                LastTransactionsPage(currencyId: currency.id)));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: equityData.map((item) {
          return CupertinoButton(
            onPressed: () {
              _goLastTransactions(context, item.currency);
            },
            child: Text(
              "${item.amount.toStringAsFixed(2)}${item.currency.sign}",
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: CupertinoColors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
          );
        }).toList());
  }
}
