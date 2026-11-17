import 'package:flutter/material.dart';

import '../utils/format.dart';

/// Bonus: Double-Tap gesture (GestureDetector) + AnimatedScale feedback.
class LikeButton extends StatefulWidget {
  const LikeButton({
    super.key,
    required this.liked,
    required this.count,
    required this.onLike,
    this.color = Colors.pinkAccent,
    this.textColor,
  });

  final bool liked;
  final int count;
  final VoidCallback onLike;
  final Color color;
  final Color? textColor;

  @override
  State<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool _pop = false;

  void _handleDoubleTap() {
    widget.onLike();
    setState(() => _pop = true);
    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) setState(() => _pop = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final fg = widget.textColor ?? widget.color;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onDoubleTap: _handleDoubleTap,
          child: AnimatedScale(
            scale: _pop ? 1.4 : 1.0,
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutBack,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: widget.color, width: 1.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(widget.liked ? Icons.favorite : Icons.favorite_border,
                      color: widget.color),
                  const SizedBox(width: 8),
                  Text(formatNumber(widget.count),
                      style: TextStyle(
                          color: fg, fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text('Double-tap to like',
            style: TextStyle(color: fg.withOpacity(0.7), fontSize: 11)),
      ],
    );
  }
}
