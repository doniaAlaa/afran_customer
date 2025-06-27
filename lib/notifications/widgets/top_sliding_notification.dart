import 'package:afran/constant/app_colors.dart';
import 'package:afran/main.dart';
import 'package:flutter/material.dart';

class NotificationBanner extends StatefulWidget {
  final String title;
  final String message;
  final VoidCallback onDismiss;

  const NotificationBanner({
    Key? key,
    required this.title,
    required this.message,
    required this.onDismiss,
  }) : super(key: key);

  @override
  State<NotificationBanner> createState() => _NotificationBannerState();
}

class _NotificationBannerState extends State<NotificationBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 300),
      vsync: this,
    );

    _slide = Tween<Offset>(begin: Offset(0, -1), end: Offset(0, 0)).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _fade = Tween<double>(begin: 0, end: 1).animate(_controller);

    _showAndAutoDismiss();
  }

  Future<void> _showAndAutoDismiss() async {
    await _controller.forward();
    await Future.delayed(Duration(seconds: 3));
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top + 12;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Positioned(
        top: top,
        left: 16,
        right: 16,
        child: SlideTransition(
          position: _slide,
          child: FadeTransition(
            opacity: _fade,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    SizedBox(height: 4),
                    Text(widget.message,
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



class NotificationService {
  static void show(String title, String message) {
    final overlay = navigatorKey.currentState?.overlay;
    if (overlay == null) return;

    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => NotificationBanner(
        title: title,
        message: message,
        onDismiss: () => entry.remove(),
      ),
    );

    overlay.insert(entry);
  }
}
