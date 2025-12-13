import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/cubit/snake_cubit.dart';

class SnakePage extends StatelessWidget {
  SnakePage({super.key});

  final List<int> snake = [121, 122, 123, 124, 125];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SnakeCubit(),
      child: BlocBuilder<SnakeCubit, List<int>>(
        builder: (context, state) {
          return Focus(
            autofocus: true,
            onKeyEvent: (node, event) {
              if (event is KeyDownEvent) {
                if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                  context.read<SnakeCubit>().moveSnake("up", 30);
                  return KeyEventResult.handled;
                }
                if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                  context.read<SnakeCubit>().moveSnake("down", 30);
                  return KeyEventResult.handled;
                }
                if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
                  context.read<SnakeCubit>().moveSnake("left", 30);
                  return KeyEventResult.handled;
                }
                if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
                  context.read<SnakeCubit>().moveSnake("right", 30);
                  return KeyEventResult.handled;
                }
              }
              return KeyEventResult.ignored;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Snake",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Divider(
                    thickness: 2,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.4,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CustomPaint(
                          painter: SnakePainter(
                            snake: state,
                            columns: 30,
                            rows: 30,
                            snakeColor: Theme.of(context).colorScheme.primary,
                          ),
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
        },
      ),
    );
  }
}

class SnakePainter extends CustomPainter {
  final List<int> snake;
  final int columns;
  final int rows;
  final Color snakeColor;

  SnakePainter({
    required this.snake,
    required this.columns,
    required this.rows,
    required this.snakeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = snakeColor
      ..style = PaintingStyle.fill;

    // Calculamos el tamaño exacto de cada celda basado en el tamaño del widget
    final cellWidth = size.width / columns;
    final cellHeight = size.height / rows;

    // Solo iteramos por la longitud de la serpiente (ej. 5 veces),
    // NO por el total de celdas (900 veces). Esto es O(N) vs O(M).
    for (int pos in snake) {
      final double x = (pos % columns) * cellWidth;
      final double y = (pos ~/ columns) * cellHeight;

      // Dibujamos un rectángulo ligeramente más pequeño para que se vean bordes
      BorderRadius borderRadius = BorderRadius.circular(2);
      Rect rect = Rect.fromLTWH(x + 1, y + 1, cellWidth - 2, cellHeight - 2);
      final RRect outer = borderRadius.toRRect(rect);

      canvas.drawRRect(outer, paint);
    }
  }

  @override
  bool shouldRepaint(covariant SnakePainter oldDelegate) {
    // Solo redibujar si la serpiente cambió de posición
    return snake != oldDelegate.snake;
  }
}
