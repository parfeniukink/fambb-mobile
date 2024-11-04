import 'package:fambb_mobile/data/cost.dart';
import 'package:fambb_mobile/widgets/section.dart';
import 'package:fambb_mobile/data/api.dart';
import 'package:flutter/cupertino.dart';

class ApplyShortcutPage extends StatefulWidget {
  final CostShortcut costShortcut;

  const ApplyShortcutPage({
    super.key,
    required this.costShortcut,
  });

  @override
  State<ApplyShortcutPage> createState() => _ApplyShortcutPageState();
}

class _ApplyShortcutPageState extends State<ApplyShortcutPage> {
  // data state
  late double value;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 160),
                Section(
                  title: "💸 Cost Value",
                  border: 3,
                  child: Column(
                    children: [
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
                              await ApiService().applyCostShortcut(
                                  widget.costShortcut.id, value);
                            },
                            color: CupertinoColors.activeGreen,
                            child: const Text("confirm",
                                style: TextStyle(color: CupertinoColors.white))
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
}
