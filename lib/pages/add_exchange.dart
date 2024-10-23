import 'package:fambb_mobile/data/user.dart';
import 'package:fambb_mobile/data/currency.dart';
import 'package:fambb_mobile/data/exchange.dart';
import 'package:fambb_mobile/widgets/section.dart';
import 'package:fambb_mobile/data/api.dart';
import 'package:flutter/cupertino.dart';

class ExchangeCreatePage extends StatefulWidget {
  final User user;
  final List<Currency> currencies;

  const ExchangeCreatePage({
    super.key,
    required this.user,
    required this.currencies,
  });

  @override
  State<ExchangeCreatePage> createState() => _ExchangeCreatePageState();
}

class _ExchangeCreatePageState extends State<ExchangeCreatePage> {
  // Data state
  DateTime date = DateTime.now();
  late double fromValue;
  late double toValue;
  late int fromCurrencyId;
  late int toCurrencyId;

  // Utils data
  late List<Map> _currenciesForModal;
  late String _selectedFromCurrencyPlaceholder;
  late String _selectedToCurrencyPlaceholder;

  @override
  void initState() {
    super.initState();

    // Adjust currencies for display in the modal
    _currenciesForModal = widget.currencies
        .map((item) => {
              "id": item.id,
              "placeholder": "${item.name} - ${item.sign}",
            })
        .toList();

    // Set default placeholders for currency selection
    final Currency? defaultCurrency = widget.user.configuration.defaultCurrency;
    _selectedFromCurrencyPlaceholder = (defaultCurrency != null)
        ? "${defaultCurrency.name} - ${defaultCurrency.sign}"
        : "from currency";
    _selectedToCurrencyPlaceholder = (defaultCurrency != null)
        ? "${defaultCurrency.name} - ${defaultCurrency.sign}"
        : "to currency";
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
                  title: "💱 Currency Exchange",
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
                        child: Text(_selectedFromCurrencyPlaceholder),
                        onPressed: () async {
                          var selectedCurrency =
                              await showCurrencyActionSheet(context, true);

                          if (selectedCurrency != null) {
                            setState(() {
                              _selectedFromCurrencyPlaceholder =
                                  selectedCurrency["placeholder"];
                              fromCurrencyId = selectedCurrency["id"];
                            });
                          }
                        },
                      ),
                      CupertinoButton(
                        child: Text(_selectedToCurrencyPlaceholder),
                        onPressed: () async {
                          var selectedCurrency =
                              await showCurrencyActionSheet(context, false);

                          if (selectedCurrency != null) {
                            setState(() {
                              _selectedToCurrencyPlaceholder =
                                  selectedCurrency["placeholder"];
                              toCurrencyId = selectedCurrency["id"];
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      CupertinoTextField(
                        placeholder: "from value",
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            fromValue = double.tryParse(value) ?? 0.0;
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                      CupertinoTextField(
                        placeholder: "to value",
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            toValue = double.tryParse(value) ?? 0.0;
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
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> acceptCallback(BuildContext context) async {
    return await ApiService().addExchange(
      ExchangeCreateBody(
        fromValue: fromValue,
        toValue: toValue,
        timestamp: date,
        fromCurrencyId: fromCurrencyId,
        toCurrencyId: toCurrencyId,
      ),
    );
  }

  Future<Map?> showCurrencyActionSheet(
      BuildContext context, bool isFromCurrency) async {
    return showCupertinoModalPopup<Map>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text(isFromCurrency
              ? "select 'from currency'"
              : "select 'to currency'"),
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
}
