import 'package:fambb_mobile/data/cost.dart';
import 'package:fambb_mobile/data/equity.dart';
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
  List<Transaction>? _lastTransactions;
  List<Equity>? _equityData;

  // Define the Api client
  ApiService api = ApiService();

  @override
  void initState() {
    super.initState();

    // fetch the main data on the screen
    _fetchUser();
    _fetchCurrencies();
    _fetchCostCategories();
    _fetchLastTransactions();
    _fetchEquity();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(onRefresh: _refreshPageState),
        SliverList(delegate: SliverChildListDelegate([pageBuilder()]))
      ],
    );
  }

  // build the page
  Widget pageBuilder() {
    return (_user == null ||
            _currencies == null ||
            _costCategories == null ||
            _equityData == null ||
            _lastTransactions == null)
        ? const Center(child: CupertinoActivityIndicator())
        : CupertinoPageScaffold(
            child: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  children: [
                    Section(
                      title: "🏦  Equity",
                      border: 3,
                      child: EquitySection(
                        equityData: _equityData!,
                        user: _user!,
                        currencies: _currencies!,
                        costCategories: _costCategories!,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Section(
                        title: "📝  Last Transactions",
                        border: 3,
                        child: LastTransactionsSection(
                          transactions: _lastTransactions!,
                        )),
                    const SizedBox(height: 10),
                    Section(
                        title: "🏃  Quick Actions",
                        border: 3,
                        child: QuickActionsSection(
                          user: _user!,
                          currencies: _currencies!,
                          costCategories: _costCategories!,
                        ))
                  ],
                ),
              ),
            )),
          );
  }

  Future<void> _fetchUser() async {
    User? result = await api.fetchUser();

    if (result != null) {
      if (!mounted) return;
      setState(() {
        _user = result;
      });
    }
  }

  Future<void> _fetchCurrencies() async {
    List<Currency>? results = await api.fetchCurrencies();

    if (results != null) {
      if (!mounted) return;
      setState(() {
        _currencies = results;
      });
    }
  }

  Future<void> _fetchCostCategories() async {
    List<CostCategory>? results = await api.fetchCostCategories();

    if (results != null) {
      if (!mounted) return;
      setState(() {
        _costCategories = results;
      });
    }
  }

  // fetch the last transactions into the LastTransactionsSection
  Future<void> _fetchLastTransactions() async {
    TransactionResults? transactionResults = await api.fetchTransactions();

    if (transactionResults != null) {
      if (!mounted) return;
      setState(() {
        _lastTransactions = transactionResults.result;
      });
    }
  }

  // fetch the equity data into the EquitySection
  Future<void> _fetchEquity() async {
    List<Equity>? equityData = await api.fetchEquity();

    if (equityData != null) {
      if (!mounted) return;
      setState(() {
        _equityData = equityData;
      });
    }
  }

  // 'pull-to-refersh' side effect call
  Future<void> _refreshPageState() async {
    await Future.wait([
      _fetchCurrencies(),
      _fetchCostCategories(),
      _fetchEquity(),
      _fetchLastTransactions(),
    ]);
  }
}
