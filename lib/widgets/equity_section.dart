import 'package:fambb_mobile/data/api.dart';
import 'package:fambb_mobile/pages/last_transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:fambb_mobile/data/equity.dart';

import 'package:fambb_mobile/data/finances.dart';

class EquitySection extends StatefulWidget {
  const EquitySection({super.key});

  @override
  State<EquitySection> createState() => _EquitySectionState();
}

class _EquitySectionState extends State<EquitySection> {
  late List<Equity> _equityData;
  late bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEquity();
  }

  Future<void> _fetchEquity() async {
    ApiService api = ApiService();
    List<Equity>? equityData = await api.fetchEquity();

    if (equityData != null) {
      setState(() {
        _equityData = equityData;
        _isLoading = false;
      });
    }
  }

  _goLastTransactions(BuildContext context, Currency currency) {
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                LastTransactionsPage(currencyId: currency.id)));
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CupertinoActivityIndicator(),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _equityData.map((item) {
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
