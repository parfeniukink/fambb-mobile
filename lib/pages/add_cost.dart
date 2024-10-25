import 'package:fambb_mobile/data/user.dart';
import 'package:fambb_mobile/data/currency.dart';
import 'package:fambb_mobile/data/cost.dart';
import 'package:fambb_mobile/widgets/section.dart';
import 'package:fambb_mobile/data/api.dart';
import 'package:flutter/cupertino.dart';

class AddCostPage extends StatefulWidget {
  final User user;
  final List<Currency> currencies;
  final List<CostCategory> costCategories;

  const AddCostPage({
    super.key,
    required this.user,
    required this.currencies,
    required this.costCategories,
  });

  @override
  State<AddCostPage> createState() => _AddCostPageState();
}

class _AddCostPageState extends State<AddCostPage> {
  // data state
  DateTime date = DateTime.now();
  late String name;
  late double value;
  late int currencyId;
  late int categoryId;

  // GUI state
  // represent currencies that are going to be displayed in the modal page
  late List<Map> _currenciesForModal;

  // just to represent the placeholder of the selected currency
  late String _selectedCurrencyPlaceholder;

  // just to represent the placeholder of the selected cost category
  late String _selectedCategoryPlaceholder;

  @override
  void initState() {
    super.initState();

    // adjust currencies that are displayed in the modal
    _currenciesForModal = widget.currencies
        .map((item) => {
              "id": item.id,
              "placeholder": "${item.name} - ${item.sign}",
            })
        .toList();

    // adjust the selected currency if the default is provided
    final Currency? defaultCurrency = widget.user.configuration.defaultCurrency;
    _selectedCurrencyPlaceholder = (defaultCurrency != null)
        ? "${defaultCurrency.name} - ${defaultCurrency.sign}"
        : "select currency";

    final CostCategory? defaultCategory =
        widget.user.configuration.defaultCostCategory;
    _selectedCategoryPlaceholder =
        (defaultCategory != null) ? defaultCategory.name : "select category";
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Section(
                  title: "💸 Cost",
                  border: 3,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 200, // Specify the height you want
                        child: CupertinoDatePicker(
                          initialDateTime: date,
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: true,
                          showDayOfWeek: true,
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() => date = newDate);
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      CupertinoButton(
                          child: Text(_selectedCurrencyPlaceholder),
                          onPressed: () async {
                            var selectedCurrency =
                                await showCurrencyActionSheet(context);

                            if (selectedCurrency != null) {
                              if (!mounted) return;
                              setState(() {
                                _selectedCurrencyPlaceholder =
                                    selectedCurrency["placeholder"];
                                currencyId = selectedCurrency["id"];
                              });
                            }
                          }),
                      CupertinoButton(
                          child: Text(_selectedCategoryPlaceholder),
                          onPressed: () async {
                            var selectedCategory =
                                await showCategoryActionSheet(context);
                            if (!mounted) return;

                            if (selectedCategory != null) {
                              if (!mounted) return;
                              setState(() {
                                _selectedCategoryPlaceholder =
                                    selectedCategory.name;
                                categoryId = selectedCategory.id;
                              });
                            }
                          }),
                      const SizedBox(height: 20),
                      CupertinoTextField(
                        placeholder: "name",
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      CupertinoTextField(
                        placeholder: "value",
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            this.value = double.tryParse(value) ?? 0.0;
                          });
                        },
                      ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CupertinoButton(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            onPressed: () => Navigator.pop(context),
                            color: CupertinoColors.systemRed,
                            child: const Text(
                              "reject",
                              style: TextStyle(
                                color: CupertinoColors.white,
                              ),
                            ),
                          ),
                          CupertinoButton(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            onPressed: () async {
                              Navigator.pop(context);
                              acceptCallback(context);
                            },
                            color: CupertinoColors.activeGreen,
                            child: const Text(
                              "submit",
                              style: TextStyle(
                                color: CupertinoColors.white,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )),
      )),
    );
  }

  Future<bool> acceptCallback(BuildContext context) async {
    return await ApiService().addCost(
      CostCreateBody(
        name: name,
        value: value,
        timestamp: date,
        currencyId: currencyId,
        categoryId: categoryId,
      ),
    );
  }

  // show currencies as `Map`.
  // note: look into the `initState` for more details
  Future<Map?> showCurrencyActionSheet(BuildContext context) async {
    return showCupertinoModalPopup<Map>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('select currency'),
          actions: _currenciesForModal.map((item) {
            return CupertinoActionSheetAction(
              child: Text(item["placeholder"]),
              onPressed: () {
                Navigator.pop(context, item);
              },
            );
          }).toList(),
        );
      },
    );
  }

  // Show cost categories and return objects on select
  Future<CostCategory?> showCategoryActionSheet(BuildContext context) async {
    return showCupertinoModalPopup<CostCategory>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('select category'),
          actions: widget.costCategories.map((category) {
            return CupertinoActionSheetAction(
              child: Text(category.name),
              onPressed: () {
                Navigator.pop(context, category);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
