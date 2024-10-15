import 'dart:developer';

import 'package:fambb_mobile/data/user.dart';
import 'package:fambb_mobile/data/currency.dart';
import 'package:fambb_mobile/data/transactions.dart';
import 'package:fambb_mobile/widgets/section.dart';
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
  late int value;
  late int currencyId;
  late int categoryId;

  // GUI state
  // represent currencies that are going to be displayed in the modal page
  late List<Map> _currenciesForModal;

  // just to represent the placeholder of the selected currency
  late String _selectedCurrencyPlaceholder;

  // just to represent the placeholder of the selected cost category
  late String _selectedCategoryPlaceholder;

  _rejectCallback(BuildContext context) {
    print("Reject the window");
  }

  _submitCallback(BuildContext context) {
    print("Submit the call");
  }

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
                  title: "🔻 Add a Cost",
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
                                await _showCurrencyActionSheet(context);
                            if (selectedCurrency != null) {
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
                                await _showCategoryActionSheet(context);
                            if (selectedCategory != null) {
                              setState(() {
                                _selectedCategoryPlaceholder =
                                    selectedCategory.name;
                                categoryId = selectedCategory.id;
                              });
                            }
                          }),
                      const SizedBox(height: 20),
                      const CupertinoTextField(
                        placeholder: "name",
                      ),
                      const SizedBox(height: 20),
                      const CupertinoTextField(
                          placeholder: "value",
                          keyboardType: TextInputType.number),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CupertinoButton(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            onPressed: () {
                              _rejectCallback(context);
                            },
                            color: CupertinoColors.systemRed,
                            child: const Text(
                              "Reject",
                              style: TextStyle(
                                color: CupertinoColors.white,
                              ),
                            ),
                          ),
                          CupertinoButton(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            onPressed: () {
                              _submitCallback(context);
                            },
                            color: CupertinoColors.activeGreen,
                            child: const Text(
                              "Submit",
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

  Future<Map?> _showCurrencyActionSheet(BuildContext context) async {
    return showCupertinoModalPopup<Map>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Select a currency'),
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

  Future<CostCategory?> _showCategoryActionSheet(BuildContext context) async {
    return showCupertinoModalPopup<CostCategory>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Select a category'),
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
