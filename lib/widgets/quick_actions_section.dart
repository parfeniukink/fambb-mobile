import 'package:flutter/cupertino.dart';

class QuickActionsSection extends StatefulWidget {
  const QuickActionsSection({super.key});

  @override
  State<QuickActionsSection> createState() => _QuickActionsSectionState();
}

class _QuickActionsSectionState extends State<QuickActionsSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CupertinoButton(
                color: CupertinoColors.systemPink,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                child: const Text(
                  "Add Cost",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: CupertinoColors.white),
                ),
                onPressed: () {}),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CupertinoButton(
                color: CupertinoColors.activeGreen,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                child: const Text(
                  "Add Income",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: CupertinoColors.white),
                ),
                onPressed: () {}),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CupertinoButton(
                color: CupertinoColors.activeBlue,
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
                child: const Text(
                  "Exchange",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: CupertinoColors.white),
                ),
                onPressed: () {}),
          ],
        ),
      ],
    );
  }
}
