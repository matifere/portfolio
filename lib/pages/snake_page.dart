import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SnakePage extends StatelessWidget {
  const SnakePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            return KeyEventResult.handled;
          }
          if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            return KeyEventResult.handled;
          }
          if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
            return KeyEventResult.handled;
          }
          if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("Snake", style: Theme.of(context).textTheme.displayLarge),
            Divider(
              thickness: 2,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 100.0,
                vertical: 16.0,
              ),
              child: SizedBox(
                height: 300,
                width: 300,
                child: Expanded(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 30,
                        ),
                    itemCount: 30 * 30,
                    itemBuilder: (context, index) {
                      return SnakeTile(
                        color: Theme.of(context).colorScheme.surface,
                      );
                    },
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 2,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.play_arrow)),
          ],
        ),
      ),
    );
  }
}

class SnakeTile extends StatelessWidget {
  const SnakeTile({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
