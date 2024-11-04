import 'package:fambb_mobile/data/user.dart';
import 'package:fambb_mobile/data/currency.dart';
import 'package:fambb_mobile/data/income.dart';
import 'package:fambb_mobile/data/transactions.dart';
import 'package:fambb_mobile/widgets/section.dart';
import 'package:fambb_mobile/data/api.dart';
import 'package:flutter/cupertino.dart';

class UpdateIncomePage extends StatefulWidget {
  final Transaction transaction;
  final User user;
  final List<Currency> currencies;

  const UpdateIncomePage({
    super.key,
    required this.transaction,
    required this.user,
    required this.currencies,
  });

  @override
  State<UpdateIncomePage> createState() => _UpdateIncomePageState();
}

class _UpdateIncomePageState extends State<UpdateIncomePage> {
  // Page utils
  late List<Map> _currenciesForModal;
  String? _selectedCurrencyPlaceholder;
  String? _selectedSourcePlaceholder;

  // payload
  String? name;
  double? value;
  DateTime? date;
  int? currencyId;
  String? source;

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
            source == null)
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
                        title: "🤑 Update Income",
                        border: 3,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 200,
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
                                child: Text(_selectedSourcePlaceholder!),
                                onPressed: () async {
                                  var selectedSource =
                                      await _showSourceActionSheet(context);

                                  if (!mounted) return;
                                  if (selectedSource != null) {
                                    setState(() {
                                      _selectedSourcePlaceholder =
                                          selectedSource;
                                      source = selectedSource;
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
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
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

  // Get the income by its 'id'
  Future<void> updateInitialPayload() async {
    Income? instance = await ApiService().getIncome(widget.transaction.id);

    if (instance != null) {
      if (!mounted) return;
      setState(() {
        // update income payload
        name = instance.name;
        value = instance.value;
        date = instance.timestamp;
        currencyId = instance.currency.id;
        source = instance.source;

        // update utils data
        _selectedCurrencyPlaceholder =
            "${instance.currency.name} - ${instance.currency.sign}";
        _selectedSourcePlaceholder = source;
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
    return await ApiService().updateIncome(
      widget.transaction.id,
      IncomeUpdateBody(
        name: name,
        value: value,
        timestamp: date,
        currencyId: currencyId,
        source: source,
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

  Future<String?> _showSourceActionSheet(BuildContext context) async {
    const sources = ["revenue", "gift", "debt", "other"];
    return showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('select source'),
          actions: sources.map((source) {
            return CupertinoActionSheetAction(
              child: Text(source),
              onPressed: () {
                Navigator.pop(context, source);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
