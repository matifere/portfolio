import 'package:flutter_bloc/flutter_bloc.dart';

class TextLoopCubit extends Cubit<String> {
  TextLoopCubit() : super('');

  final List<String> texts = [
    "Welcome to my Portfolio",
    "I'm Matias",
    "Flutter Developer",
  ];

  void startLoop() async {
    int index = 0;
    while (!isClosed) {
      final text = texts[index];

      for (int i = 0; i <= text.length; i++) {
        if (isClosed) return;
        emit(text.substring(0, i));
        await Future.delayed(const Duration(milliseconds: 100));
      }

      if (isClosed) return;
      await Future.delayed(const Duration(seconds: 2));
      index = (index + 1) % texts.length;
    }
  }
}
