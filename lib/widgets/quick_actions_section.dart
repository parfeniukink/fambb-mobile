import 'package:fambb_mobile/pages/add_exchange.dart';
import 'package:fambb_mobile/pages/add_income.dart';
import 'package:flutter/cupertino.dart';
import 'package:fambb_mobile/pages/add_cost.dart';
import 'package:fambb_mobile/data/user.dart';
import 'package:fambb_mobile/data/currency.dart';
import 'package:fambb_mobile/data/cost.dart';

class QuickActionsSection extends StatefulWidget {
  final User user;
  final List<Currency> currencies;
  final List<CostCategory> costCategories;

  const QuickActionsSection({
    super.key,
    required this.user,
    required this.currencies,
    required this.costCategories,
  });

  @override
  State<QuickActionsSection> createState() => _QuickActionsSectionState();
}

class _QuickActionsSectionState extends State<QuickActionsSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CupertinoButton(
                color: CupertinoColors.systemPink,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                child: const Text(
                  "💸 Cost",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: CupertinoColors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => AddCostPage(
                        user: widget.user,
                        currencies: widget.currencies,
                        costCategories: widget.costCategories,
                      ),
                    ),
                  );
                }),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CupertinoButton(
                color: CupertinoColors.activeGreen,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                child: const Text(
                  "🤑 Income",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: CupertinoColors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => AddIncomePage(
                        user: widget.user,
                        currencies: widget.currencies,
                      ),
                    ),
                  );
                }),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CupertinoButton(
                color: CupertinoColors.activeBlue,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                child: const Text(
                  "Exchange",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: CupertinoColors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => ExchangeCreatePage(
                        user: widget.user,
                        currencies: widget.currencies,
                      ),
                    ),
                  );
                }),
          ],
        ),
      ],
    );
  }
}
