import 'package:fambb_mobile/widgets/section.dart';
import 'package:flutter/cupertino.dart';

class AddCostFormPage extends StatefulWidget {
  const AddCostFormPage({super.key});

  @override
  State<AddCostFormPage> createState() => _AddCostFormPageState();
}

class _AddCostFormPageState extends State<AddCostFormPage> {
  DateTime date = DateTime.now();
  late String name;
  late int value;
  late int currencyId;
  late int categoryId;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 100),
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
                          child: const Text("select currency"),
                          onPressed: () {
                            Navigator.of(context)
                                .restorablePush(_currenciesModalBuilder);
                          }),
                      CupertinoButton(
                          child: const Text("select category"),
                          onPressed: () {
                            Navigator.of(context)
                                .restorablePush(_categoriesModalBuilder);
                          }),
                      const SizedBox(height: 20),
                      const CupertinoTextField(
                        placeholder: "name",
                      ),
                      const SizedBox(height: 20),
                      const CupertinoTextField(
                          placeholder: "value",
                          keyboardType: TextInputType.number),
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
    return CupertinoModalPopupRoute<void>(
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('select the currency from the list'),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              child: const Text('Action One'),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  @pragma('vm:entry-point')
  static Route<void> _categoriesModalBuilder(
      BuildContext context, Object? arguments) {
    return CupertinoModalPopupRoute<void>(
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Title'),
          message: const Text('Message'),
          actions: <CupertinoActionSheetAction>[
            CupertinoActionSheetAction(
              child: const Text('Action One'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Action Two'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
