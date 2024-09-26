import 'dart:developer';

import 'package:fambb_mobile/widgets/section.dart';
import 'package:fambb_mobile/data/user.dart';
import 'package:fambb_mobile/data/currency.dart';
import 'package:fambb_mobile/data/transactions.dart';
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
  DateTime date = DateTime.now();
  late String name;
  late int value;
  late int currencyId;
  late int categoryId;
  late List<Map> _currenciesForModal;

  _rejectCallback(BuildContext context) {
    print("Reject the window");
  }

  _submitCallback(BuildContext context) {
    print("Submit the call");
  }

  _setCurrenciesForModal() {
    _currenciesForModal = widget.currencies
        .map((item) => {
              "id": item.id,
              "placeholder": "${item.name} - ${item.sign}",
            })
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _setCurrenciesForModal();
  }

  @override
  Widget build(BuildContext context) {
    Currency? defaultCurrency = widget.user.configuration.defaultCurrency;
    CostCategory? defaultCostCategory =
        widget.user.configuration.defaultCostCategory;
    String? currencyPlaceholder =
        (defaultCurrency != null) ? defaultCurrency.sign : null;
    String? categoryPlaceholder =
        (defaultCostCategory != null) ? defaultCostCategory.name : null;

    if (defaultCurrency != null) {
      currencyPlaceholder = defaultCurrency.sign;
    }

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
                          child: (currencyPlaceholder == null)
                              ? const Text("select currency")
                              : Text("currency $currencyPlaceholder"),
                          onPressed: () {
                            Navigator.of(context).restorablePush(
                              _currenciesModalBuilder,
                              arguments: _currenciesForModal,
                            );
                          }),
                      CupertinoButton(
                          child: (categoryPlaceholder == null)
                              ? const Text("select category")
                              : Text("category [$categoryPlaceholder]"),
                          onPressed: () {
                            debugger();

                            Navigator.of(context).restorablePush(
                              _categoriesModalBuilder,
                            );
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

  @pragma('vm:entry-point')
  static Route<void> _currenciesModalBuilder(
      BuildContext context, Object? arguments) {
    debugger();
    final List<Currency> currencies = (arguments as List<Currency>?) ?? [];

    return CupertinoModalPopupRoute<void>(
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Select the currency from the list'),
          actions: currencies.map((currency) {
            return CupertinoActionSheetAction(
              child: Text(currency.name),
              onPressed: () {
                Navigator.pop(context, currency);
              },
            );
          }).toList(),
        );
      },
    );
  }

  @pragma('vm:entry-point')
  static Route<void> _categoriesModalBuilder(
      BuildContext context, Object? arguments) {
    final List<CostCategory> categories =
        (arguments as List<CostCategory>?) ?? [];
    return CupertinoModalPopupRoute<void>(
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Select a category from the list'),
          actions: categories.map((category) {
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
