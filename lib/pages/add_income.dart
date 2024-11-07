import 'package:fambb_mobile/data/user.dart';
import 'package:fambb_mobile/data/currency.dart';
import 'package:fambb_mobile/data/income.dart';
import 'package:fambb_mobile/widgets/section.dart';
import 'package:fambb_mobile/data/api.dart';
import 'package:flutter/cupertino.dart';

class AddIncomePage extends StatefulWidget {
  final User user;
  final List<Currency> currencies;

  const AddIncomePage({
    super.key,
    required this.user,
    required this.currencies,
  });

  @override
  State<AddIncomePage> createState() => _AddIncomePageState();
}

class _AddIncomePageState extends State<AddIncomePage> {
  // data state
  DateTime date = DateTime.now();
  late String name;
  String incomeSource = "revenue";
  late double value;
  late int currencyId;
  late int categoryId;

  // Utils data
  late List<Map> _currenciesForModal;
  late String _selectedCurrencyPlaceholder;

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

    if (defaultCurrency != null) {
      currencyId = defaultCurrency.id;
    }
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
                  title: "🤑 Income",
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
                          child: Text(incomeSource),
                          onPressed: () async {
                            var selectedSource =
                                await showSourcesActionSheet(context);

                            if (selectedSource != null) {
                              if (!mounted) return;
                              setState(() {
                                incomeSource = selectedSource;
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
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChanged: (value) {
                          setState(() {
                            this.value = double.tryParse(value.replaceAll(",", ".")) ?? 0.0;
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
                              await acceptCallback(context);
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

  Future<bool> acceptCallback(BuildContext context) async {
    // TODO: Add the validation if some values are not set yet.
    //       Might be a good idea handing the error here: `LateInitializationError`.
    return await ApiService().addIncome(
      IncomeCreateBody(
        name: name,
        value: value,
        source: incomeSource,
        timestamp: date,
        currencyId: currencyId,
      ),
    );
  }

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

  Future<String?> showSourcesActionSheet(BuildContext context) async {
    return showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) {
        List<String> actions = ["revenue", "gift", "debt", "other"];
        return CupertinoActionSheet(
          title: const Text('select source'),
          actions: actions.map((item) {
            return CupertinoActionSheetAction(
              child: Text(item),
              onPressed: () {
                Navigator.pop(context, item);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
