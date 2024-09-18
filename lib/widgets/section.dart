import 'package:flutter/cupertino.dart';

class Section extends StatelessWidget {
  final String title;
  final Widget child; // Section content
  final int border; // Border width: 0 means no border
  final VoidCallback? onClick; // Optional callback for section press

  const Section({
    super.key,
    required this.title,
    this.border = 0, // Default no border
    this.onClick,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick, // Triggers the callback if provided
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.all(26.0),
        decoration: BoxDecoration(
          border: border > 0
              ? Border.all(
                  color: CupertinoColors.systemGrey,
                  width: border.toDouble(),
                  style: BorderStyle.solid,
                )
              : null, // No border if width is 0
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title of the section
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 36.0),
            child,
          ],
        ),
      ),
    );
  }
}
