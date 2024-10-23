// import 'package:fambb_mobile/data/api.dart';
import 'package:fambb_mobile/pages/apply_shortcut.dart';
import 'package:fambb_mobile/widgets/popup.dart';
import 'package:flutter/cupertino.dart';
import 'package:fambb_mobile/data/cost.dart';
import 'package:fambb_mobile/data/api.dart';

class CostShortcutCard extends StatelessWidget {
  final CostShortcut shortcut;

  const CostShortcutCard({super.key, required this.shortcut});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (shortcut.value == null) {
          await Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ApplyShortcutPage(costShortcut: shortcut),
            ),
          );
        } else {
          ApiService().applyCostShortcut(shortcut.id, shortcut.value);
          // TODO: update the message depending on the api call result
          showPopup(
            context,
            color: CupertinoColors.activeGreen,
            message: "saved",
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: CupertinoColors.systemGrey, width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              shortcut.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            (shortcut.value != null)
                ? Text(
                    '${shortcut.currency.sign}${shortcut.value!.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16),
                  )
                : Text('${shortcut.currency.sign}...',
                    style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            Text(
              shortcut.category.name,
              style: const TextStyle(
                color: CupertinoColors.systemGrey2,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
