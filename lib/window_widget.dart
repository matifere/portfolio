import 'package:flutter/material.dart';
import 'package:portfolio/window_model.dart';

class WindowWidget extends StatefulWidget {
  final WindowModel window;
  final VoidCallback onClose;
  final VoidCallback onFocus;
  final VoidCallback onMinimize;
  final VoidCallback onMaximize;
  final Size screenSize;

  const WindowWidget({
    super.key,
    required this.window,
    required this.onClose,
    required this.onFocus,
    required this.onMinimize,
    required this.onMaximize,
    required this.screenSize,
  });

  @override
  State<WindowWidget> createState() => _WindowWidgetState();
}

class _WindowWidgetState extends State<WindowWidget> {
  double initialHeight = 50;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1), () {
      initialHeight = widget.window.size.height;
      setState(() {});
    });
    widget.window.position.addListener(_handlePositionChange);
  }

  @override
  void dispose() {
    widget.window.position.removeListener(_handlePositionChange);
    super.dispose();
  }

  void _handlePositionChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Offset>(
      valueListenable: widget.window.position,
      builder: (context, currentPos, child) {
        return Positioned(
          left: currentPos.dx,
          top: currentPos.dy,
          child: GestureDetector(
            onPanUpdate: (details) => _handleDrag(details, currentPos),

            onTap: widget.onFocus,
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
      widget.screenSize.width - widget.window.size.width,
    );

    final double clampedY = newOffset.dy.clamp(
      0,
      widget.screenSize.height - widget.window.size.height - 48,
    );

    widget.window.position.value = Offset(clampedX, clampedY);
  }

  Widget _buildWindowVisuals() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.bounceInOut,
      width: widget.window.size.width,
      height: initialHeight,
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
              spacing: 16,
              children: [
                Text(
                  widget.window.title,
                  style: const TextStyle(color: Colors.white70),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(
                    Icons.minimize,
                    size: 16,
                    color: Colors.white54,
                  ),
                  onPressed: widget.onMinimize,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 16,
                    color: Colors.white54,
                  ),
                  onPressed: widget.onClose,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          Expanded(child: widget.window.content),
        ],
      ),
    );
  }
}
