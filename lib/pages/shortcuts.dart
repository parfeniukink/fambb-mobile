import 'package:flutter/cupertino.dart';
import 'package:fambb_mobile/data/api.dart';
import 'package:fambb_mobile/data/cost.dart';
import 'package:fambb_mobile/widgets/cost_shortcut.dart';

class ShortcutsPage extends StatefulWidget {
  const ShortcutsPage({super.key});

  @override
  State<ShortcutsPage> createState() => _ShortcutsPageState();
}

class _ShortcutsPageState extends State<ShortcutsPage> {
  List<CostShortcut>? _costShortcuts;

  ApiService api = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchCostShortcuts();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: CustomScrollView(
          slivers: [
            CupertinoSliverRefreshControl(onRefresh: _fetchCostShortcuts),
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              sliver: SliverToBoxAdapter(
                child: Text(
                  "💰  Cost Shortcuts",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
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
}
