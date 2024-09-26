import 'package:fambb_mobile/data/user.dart';
import 'package:fambb_mobile/widgets/equity_section.dart';
import 'package:fambb_mobile/widgets/last_transactions_section.dart';
import 'package:fambb_mobile/widgets/quick_actions_section.dart';
import 'package:fambb_mobile/widgets/section.dart';
import 'package:fambb_mobile/data/api.dart';
import 'package:fambb_mobile/data/currency.dart';
import 'package:fambb_mobile/data/transactions.dart';
import 'package:flutter/cupertino.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? _user;
  List<Currency>? _currencies;
  List<CostCategory>? _costCategories;

  @override
  void initState() {
    super.initState();
    _fetchUser();
    _fetchCurrencies();
    _fetchCostCategories();
  }

  Future<void> _fetchUser() async {
    User? result = await ApiService().fetchUser();

    if (result != null) {
      setState(() {
        _user = result;
      });
    }
  }

  Future<void> _fetchCurrencies() async {
    List<Currency>? results = await ApiService().fetchCurrencies();

    if (results != null) {
      setState(() {
        _currencies = results;
      });
    }
  }

  Future<void> _fetchCostCategories() async {
    List<CostCategory>? results = await ApiService().fetchCostCategories();

    if (results != null) {
      setState(() {
        _costCategories = results;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_user == null && _currencies == null && _costCategories == null)
        ? const CupertinoActivityIndicator()
        : CupertinoPageScaffold(
            child: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  children: [
                    const Section(
                      title: "🏦  Equity",
                      border: 3,
                      child: EquitySection(),
                    ),
                    const Section(
                      title: "📝  Last Transactions",
                      border: 3,
                      child: LastTransactionsSection(),
                    ),
                    Section(
                      title: "🏃  Quick Actions",
                      border: 3,
                      child: (_user == null ||
                              _currencies == null ||
                              _costCategories == null)
                          ? const CupertinoActivityIndicator()
                          : QuickActionsSection(
                              user: _user!,
                              currencies: _currencies!,
                              costCategories: _costCategories!,
                            ),
                    )
                  ],
                ),
              ),
            )),
          );
  }
}
