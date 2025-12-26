import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/cubit/snake_cubit.dart';
import 'package:portfolio/cubit/snake_food_cubit.dart';

class SnakePage extends StatelessWidget {
  SnakePage({super.key});

  // * pos inicial del snake
  final List<int> snake = [121, 122, 123, 124, 125];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SnakeCubit()),
        BlocProvider(create: (context) => SnakeFoodCubit()),
      ],
      child: BlocBuilder<SnakeFoodCubit, List<int>>(
        builder: (context, foodState) {
          return BlocBuilder<SnakeCubit, List<int>>(
            builder: (context, snakeState) {
              return Focus(
                autofocus: true,
                onKeyEvent: (node, event) {
                  if (event is KeyDownEvent) {
                    if (event.logicalKey == LogicalKeyboardKey.arrowUp ||
                        event.logicalKey == LogicalKeyboardKey.keyK) {
                      context.read<SnakeCubit>().moveSnake("up", 30);
                      return KeyEventResult.handled;
                    }
                    if (event.logicalKey == LogicalKeyboardKey.arrowDown ||
                        event.logicalKey == LogicalKeyboardKey.keyJ) {
                      context.read<SnakeCubit>().moveSnake("down", 30);
                      return KeyEventResult.handled;
                    }
                    if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
                        event.logicalKey == LogicalKeyboardKey.keyH) {
                      context.read<SnakeCubit>().moveSnake("left", 30);
                      return KeyEventResult.handled;
                    }
                    if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
                        event.logicalKey == LogicalKeyboardKey.keyL) {
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
                                snake: snakeState,
                                food: foodState,
                                foodColor: Colors.green,
                                columns: 30,
                                rows: 30,
                                snakeColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                context: context,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 2,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.play_arrow),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SnakePainter extends CustomPainter {
  final List<int> snake;
  final List<int> food;
  final int columns;
  final int rows;
  final Color snakeColor;
  final Color foodColor;
  final BuildContext context;

  SnakePainter({
    required this.snake,
    required this.columns,
    required this.rows,
    required this.snakeColor,
    required this.food,
    required this.foodColor,

    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final snakePaint = Paint()
      ..color = snakeColor
      ..style = PaintingStyle.fill;
    final foodPaint = Paint()
      ..color = foodColor
      ..style = PaintingStyle.fill;

    final cellWidth = size.width / columns;
    final cellHeight = size.height / rows;
    // pierde porque se come a si mismo
    List<int> canibal = List.from(snake);
    canibal.removeLast();
    if (canibal.contains(snake.last)) {
      context.read<SnakeCubit>().reset();
    }
    //logica para comer
    for (int element in food) {
      if (snake.contains(element)) {
        context.read<SnakeCubit>().comer(element);
        context.read<SnakeFoodCubit>().comer(element);
        if (food.isEmpty) {
          context.read<SnakeFoodCubit>().crearComida(
            Random().nextInt(2) + 1,
            snake,
          );
        }
      }
    }
    // pintar comida
    for (int pos in food) {
      final double x = (pos % columns) * cellWidth;
      final double y = (pos ~/ columns) * cellHeight;

      BorderRadius borderRadius = BorderRadius.circular(2);
      Rect rect = Rect.fromLTWH(x + 1, y + 1, cellWidth - 2, cellHeight - 2);
      final RRect outer = borderRadius.toRRect(rect);

      canvas.drawRRect(outer, foodPaint);
    }
    //pintar snake
    for (int pos in snake) {
      final double x = (pos % columns) * cellWidth;
      final double y = (pos ~/ columns) * cellHeight;

      BorderRadius borderRadius = BorderRadius.circular(2);
      Rect rect = Rect.fromLTWH(x + 1, y + 1, cellWidth - 2, cellHeight - 2);
      final RRect outer = borderRadius.toRRect(rect);

      canvas.drawRRect(outer, snakePaint);
    }
  }

  @override
  bool shouldRepaint(covariant SnakePainter oldDelegate) {
    // Solo redibujar si la serpiente cambió de posición
    return snake != oldDelegate.snake;
  }
}
