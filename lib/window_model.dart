import 'package:flutter/material.dart';

class WindowModel {
  final String id;
  final String title;
  final Widget content;
  final Size size;

  final ValueNotifier<Offset> position;

  WindowModel({
    required this.id,
    required this.title,
    required this.content,
    Offset initialPosition = const Offset(100, 100),
    this.size = const Size(400, 300),
  }) : position = ValueNotifier(initialPosition);

  void dispose() {
    position.dispose();
  }
}
