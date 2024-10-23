import 'package:flutter/cupertino.dart';
import 'package:fambb_mobile/data/cost.dart';

class CostShortcutCard extends StatelessWidget {
  final CostShortcut shortcut;

  const CostShortcutCard({super.key, required this.shortcut});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapOnCard,
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

  void tapOnCard() {
    print(shortcut.name);
  }
}
