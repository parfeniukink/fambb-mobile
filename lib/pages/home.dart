import 'package:fambb_mobile/widgets/equity_section.dart';
import 'package:fambb_mobile/widgets/last_transactions_section.dart';
import 'package:fambb_mobile/widgets/quick_actions_section.dart';
import 'package:fambb_mobile/widgets/section.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              Section(
                title: "🏦  Equity",
                border: 5,
                child: EquitySection(),
              ),
              Section(
                title: "📝  Last Transactions",
                border: 5,
                child: LastTransactionsSection(),
              ),
              Section(
                title: "🏃  Quick Actions",
                border: 5,
                child: QuickActionsSection(),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
