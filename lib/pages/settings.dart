import 'dart:developer';

import 'package:fambb_mobile/data/api.dart';
import 'package:fambb_mobile/data/cost.dart';
import 'package:fambb_mobile/data/currency.dart';
import 'package:fambb_mobile/data/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:fambb_mobile/widgets/section.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // data definition
  int? defaultCurrencyId;
  int? defaultCostCategoryId;

  User? user;
  List<Currency>? currencies;
  List<CostCategory>? costCategories;

  late List<Map> _currenciesForActionSheet;
  String? _selectedCurrencyPlaceholder;
  String? _selectedCostCategoryPlaceholder;

  ApiService api = ApiService();

  @override
  void initState() {
    super.initState();
    updateInitialPayload();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: (user == null)
                ? const Center(child: CupertinoActivityIndicator())
                : buildPage()),
      ),
    );
  }

  Widget buildPage() {
    return Column(
      children: [
        const SizedBox(height: 280),
        Section(
          border: 3,
          title: "🔧 Settings",
          child: Column(
            children: [
              CupertinoButton(
                  child: Text(
                    _selectedCurrencyPlaceholder ??
                        "- select default cost currency",
                    textAlign: TextAlign.left,
                  ),
                  onPressed: () async {
                    var selectedCurrency =
                        await showCurrencyActionSheet(context);

                    if (selectedCurrency != null && mounted) {
                      setState(() {
                        // update the UI and make the query
                        _selectedCurrencyPlaceholder =
                            selectedCurrency["placeholder"];
                        defaultCurrencyId = selectedCurrency["id"];
                      });
                    }
                  }),
              CupertinoButton(
                  child: Text(
                    _selectedCostCategoryPlaceholder ??
                        "- select default cost category",
                    textAlign: TextAlign.left,
                  ),
                  onPressed: () async {
                    CostCategory? selectedCategory =
                        await showCostCatergoriesActionSheet(context);

                    if (selectedCategory != null && mounted) {
                      setState(() {
                        _selectedCostCategoryPlaceholder =
                            selectedCategory.name;
                        defaultCostCategoryId = selectedCategory.id;
                      });
                    }
                  }),
            ],
          ),
        )
      ],
    );
  }

  Future<void> updateInitialPayload() async {
    await Future.wait([
      _fetchUser(),
      _fetchCurrencies(),
      _fetchCostCategories(),
    ]);

    if (currencies != null && mounted) {
      _currenciesForActionSheet = currencies!
          .map((item) => {
                "id": item.id,
                "placeholder":
                    "default cost currency is ${item.name}[${item.sign}]",
                "actionItemPlaceholder": "${item.name} - ${item.sign}",
              })
          .toList();
    }

    if (user != null && mounted) {
      final Currency? currency = user!.configuration.defaultCurrency;
      final CostCategory? category = user!.configuration.defaultCostCategory;

      _selectedCurrencyPlaceholder = (currency != null)
          ? "+ default cost currency is ${currency.name}[${currency.sign}]"
          : "- select default cost currency";

      _selectedCostCategoryPlaceholder = (category != null)
          ? "+ default cost currency is ${category.name}"
          : "- select default cost category";

      if (currency != null) {
        defaultCurrencyId = currency.id;
      }
      if (category != null) {
        defaultCostCategoryId = category.id;
      }
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

  // show currencies as `Map`.
  // note: look into the `initState` for more details
  Future<Map?> showCurrencyActionSheet(BuildContext context) async {
    return showCupertinoModalPopup<Map>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('select default cost currency'),
          actions: _currenciesForActionSheet.map((item) {
            return CupertinoActionSheetAction(
              child: Text(item["actionItemPlaceholder"]),
              onPressed: () {
                Navigator.pop(context, item);
                defaultCurrencyId = item["id"];
                api.updateUserConfiguration(UserConfigurationUpdateBody(
                  defaultCurrencyId: defaultCurrencyId,
                  defaultCostCategoryId: defaultCostCategoryId,
                ));
              },
            );
          }).toList(),
        );
      },
    );
  }

  // Show cost categories and return objects on select
  Future<CostCategory?> showCostCatergoriesActionSheet(
      BuildContext context) async {
    return showCupertinoModalPopup<CostCategory>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('select default cost category'),
          actions: costCategories!.map((item) {
            return CupertinoActionSheetAction(
              child: Text(item.name),
              onPressed: () {
                Navigator.pop(context, item);
                defaultCostCategoryId = item.id;
                api.updateUserConfiguration(UserConfigurationUpdateBody(
                  defaultCurrencyId: defaultCurrencyId,
                  defaultCostCategoryId: defaultCostCategoryId,
                ));
              },
            );
          }).toList(),
        );
      },
    );
  }
}
