import 'package:fambb_mobile/pages/add_cost_shortcut.dart';
import 'package:flutter/cupertino.dart';
import 'package:fambb_mobile/data/api.dart';
import 'package:fambb_mobile/data/user.dart';
import 'package:fambb_mobile/data/currency.dart';
import 'package:fambb_mobile/data/cost.dart';
import 'package:fambb_mobile/widgets/cost_shortcut.dart';

class ShortcutsPage extends StatefulWidget {
  const ShortcutsPage({super.key});

  @override
  State<ShortcutsPage> createState() => _ShortcutsPageState();
}

class _ShortcutsPageState extends State<ShortcutsPage> {
  User? user;
  List<Currency>? currencies;
  List<CostCategory>? costCategories;
  List<CostShortcut>? _costShortcuts;

  ApiService api = ApiService();

  @override
  void initState() {
    super.initState();

    // fetch the main data on the screen
    _fetchCostShortcuts();
    _fetchUser();
    _fetchCurrencies();
    _fetchCostCategories();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverRefreshControl(onRefresh: _fetchCostShortcuts),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              sliver: SliverToBoxAdapter(
                  child: Row(
                children: [
                  const Text(
                    "💰 Cost Shortcuts",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  const Spacer(),
                  CupertinoButton(
                      onPressed: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => AddCostShortcutPage(
                                      user: user!,
                                      currencies: currencies!,
                                      costCategories: costCategories!,
                                    )),
                          ),
                      padding: EdgeInsets.zero,
                      child: const Icon(CupertinoIcons.add))
                ],
              )),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 26)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              sliver: _buildCostShortcutGrid(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCostShortcutGrid() {
    if (_costShortcuts == null) {
      return const SliverToBoxAdapter(
        child: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CostShortcutCard(
            shortcut: _costShortcuts![index], // Adjust based on your data
          );
        },
        childCount: _costShortcuts!.length,
      ),
    );
  }

  Future<void> _fetchCostShortcuts() async {
    List<CostShortcut>? results = await api.fetchCostShortcuts();
    if (results != null && mounted) {
      setState(() {
        _costShortcuts = results;
      });
    }
  }

  Future<void> _fetchUser() async {
    User? result = await api.fetchUser();

    if (result != null && mounted) {
      setState(() {
        user = result;
      });
    }
  }

  Future<void> _fetchCurrencies() async {
    List<Currency>? results = await api.fetchCurrencies();

    if (results != null && mounted) {
      setState(() {
        currencies = results;
      });
    }
  }

  Future<void> _fetchCostCategories() async {
    List<CostCategory>? results = await api.fetchCostCategories();

    if (results != null && mounted) {
      setState(() {
        costCategories = results;
      });
    }
  }
}
