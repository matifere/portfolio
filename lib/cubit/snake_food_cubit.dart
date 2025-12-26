import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

class SnakeFoodCubit extends Cubit<List<int>> {
  SnakeFoodCubit() : super([Random().nextInt(900), Random().nextInt(900)]);

  void crearComida(int nivel, List<int> snake) {
    for (var i = 0; i < nivel; i++) {
      int nuevaComida = Random().nextInt(900);
      //evitamos que aparezca sobre el snake, seguro hay una forma mas elegante de hacer esto
      while (snake.contains(nuevaComida)) {
        nuevaComida = Random().nextInt(900);
      }
      state.add(nuevaComida);
    }
    emit(state);
  }

  void comer(int comida) {
    state.remove(comida);
    emit(state);
  }
}
