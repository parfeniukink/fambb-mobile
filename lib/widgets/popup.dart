import 'dart:async';
import 'package:flutter/cupertino.dart';

class Popup extends StatefulWidget {
  final Color color;
  final String message;

  const Popup({super.key, required this.color, required this.message});

  @override
  State<Popup> createState() => _PopupState();
}

class _PopupState extends State<Popup> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Start the slide-up animation
    _controller.forward();

    // Automatically dismiss the popup after 2 seconds without any navigation
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          widget.message,
          style: const TextStyle(
            color: CupertinoColors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

void showPopup(BuildContext context,
    {required Color color, required String message}) {
  OverlayEntry overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      bottom: 20.0, // Popup appears near the bottom
      left: 16.0,
      right: 16.0,
      child: CupertinoUserInterfaceLevel(
        data: CupertinoUserInterfaceLevelData.elevated,
        child: Popup(color: color, message: message),
      ),
    ),
  );

  Overlay.of(context).insert(overlayEntry);

  // Automatically remove the popup from the overlay after 2 seconds
  Timer(
    const Duration(seconds: 2),
    () {
      overlayEntry.remove(); // Remove the popup from the overlay
    },
  );
}
