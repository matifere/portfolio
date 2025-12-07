import 'package:flutter/material.dart';
import 'package:portfolio/window_model.dart';

class WindowWidget extends StatelessWidget {
  final WindowModel window;
  final VoidCallback onClose;
  final VoidCallback onFocus;
  final Size screenSize;

  const WindowWidget({
    super.key,
    required this.window,
    required this.onClose,
    required this.onFocus,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Offset>(
      valueListenable: window.position,
      builder: (context, currentPos, child) {
        return Positioned(
          left: currentPos.dx,
          top: currentPos.dy,
          child: GestureDetector(
            onPanUpdate: (details) => _handleDrag(details, currentPos),

            onTap: onFocus,
            child: child,
          ),
        );
      },
      child: _buildWindowVisuals(),
    );
  }

  void _handleDrag(DragUpdateDetails details, Offset currentPos) {
    final newOffset = currentPos + details.delta;

    final double clampedX = newOffset.dx.clamp(
      0,
      screenSize.width - window.size.width,
    );

    final double clampedY = newOffset.dy.clamp(
      0,
      screenSize.height - window.size.height - 48,
    );

    window.position.value = Offset(clampedX, clampedY);
  }

  Widget _buildWindowVisuals() {
    return Container(
      width: window.size.width,
      height: window.size.height,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withAlpha(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white10)),
            ),
            child: Row(
              children: [
                Text(
                  window.title,
                  style: const TextStyle(color: Colors.white70),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.white54,
                  ),
                  onPressed: onClose,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          Expanded(child: window.content),
        ],
      ),
    );
  }
}
