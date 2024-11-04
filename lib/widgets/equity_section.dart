import 'package:fambb_mobile/data/cost.dart';
import 'package:fambb_mobile/data/user.dart';
import 'package:fambb_mobile/pages/last_transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:fambb_mobile/data/equity.dart';
import 'package:fambb_mobile/data/currency.dart';
import 'package:fambb_mobile/domain/services.dart';

class EquitySection extends StatelessWidget {
  final List<Equity> equityData;
  final User user;
  final List<Currency> currencies;
  final List<CostCategory> costCategories;

  const EquitySection({
    super.key,
    required this.equityData,
    required this.user,
    required this.currencies,
    required this.costCategories,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: equityData.map((item) {
          return CupertinoButton(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => LastTransactionsPage(
                    currencyId: item.currency.id,
                    user: user,
                    currencies: currencies,
                    costCategories: costCategories,
                  ),
                ),
              );
            },
            child: Text(
              "${formatAmount(item.amount)} ${item.currency.sign}",
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                // color: CupertinoColors.activeBlue,
                fontStyle: FontStyle.italic,
              ),
            ),
          );
        }).toList());
  }
}
