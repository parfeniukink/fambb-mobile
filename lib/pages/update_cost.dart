import 'package:fambb_mobile/data/user.dart';
import 'package:fambb_mobile/data/currency.dart';
import 'package:fambb_mobile/data/cost.dart';
import 'package:fambb_mobile/data/transactions.dart';
import 'package:fambb_mobile/widgets/section.dart';
import 'package:fambb_mobile/data/api.dart';
import 'package:flutter/cupertino.dart';

class UpdateCostPage extends StatefulWidget {
  final Transaction transaction;
  final User user;
  final List<Currency> currencies;
  final List<CostCategory> costCategories;

  const UpdateCostPage({
    super.key,
    required this.transaction,
    required this.user,
    required this.currencies,
    required this.costCategories,
  });

  @override
  State<UpdateCostPage> createState() => _UpdateCostPageState();
}

class _UpdateCostPageState extends State<UpdateCostPage> {
  // Page utils
  late List<Map> _currenciesForModal;
  String? _selectedCurrencyPlaceholder;
  String? _selectedCategoryPlaceholder;

  // payload
  String? name;
  double? value;
  DateTime? date;
  int? currencyId;
  int? categoryId;

  @override
  void initState() {
    super.initState();
    updateInitialPayload();
  }

  @override
  Widget build(BuildContext context) {
    return (name == null ||
            value == null ||
            date == null ||
            currencyId == null ||
            categoryId == null)
        ? const CupertinoActivityIndicator()
        : CupertinoPageScaffold(
            child: SafeArea(
                child: SingleChildScrollView(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      Section(
                        title: "💸 Update Cost",
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
                                child: Text(_selectedCurrencyPlaceholder!),
                                onPressed: () async {
                                  var selectedCurrency =
                                      await _showCurrencyActionSheet(context);

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
                                child: Text(_selectedCategoryPlaceholder!),
                                onPressed: () async {
                                  var selectedCategory =
                                      await _showCategoryActionSheet(context);

                                  if (selectedCategory != null && mounted) {
                                    setState(() {
                                      _selectedCategoryPlaceholder =
                                          selectedCategory.name;
                                      categoryId = selectedCategory.id;
                                    });
                                  }
                                }),
                            const SizedBox(height: 20),
                            CupertinoTextField(
                              placeholder: name ?? "loading",
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                            ),
                            const SizedBox(height: 20),
                            CupertinoTextField(
                              placeholder: (value != null)
                                  ? value.toString()
                                  : "loading",
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
                                    await submitCallback(context);
                                  },
                                  color: CupertinoColors.activeGreen,
                                  child: const Text(
                                    "confirm",
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

  // Get the cost by its 'id'
  Future<void> updateInitialPayload() async {
    Cost? instance = await ApiService().getCost(widget.transaction.id);

    if (instance != null) {
      if (!mounted) return;
      setState(() {
        // update cost payload
        name = instance.name;
        value = instance.value;
        date = instance.timestamp;
        currencyId = instance.currency.id;
        categoryId = instance.category.id;

        // update utils data
        _selectedCurrencyPlaceholder =
            "${instance.currency.name} - ${instance.currency.sign}";

        _selectedCategoryPlaceholder = instance.category.name;

        _currenciesForModal = widget.currencies
            .map((item) => {
                  "id": item.id,
                  "placeholder": "${item.name} - ${item.sign}",
                })
            .toList();
      });
    }
  }

  Future<bool> submitCallback(BuildContext context) async {
    return await ApiService().updateCost(
      widget.transaction.id,
      CostUpdateBody(
        name: name,
        value: value,
        timestamp: date,
        currencyId: currencyId,
        categoryId: categoryId,
      ),
    );
  }

  Future<Map?> _showCurrencyActionSheet(BuildContext context) async {
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

  Future<CostCategory?> _showCategoryActionSheet(BuildContext context) async {
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
