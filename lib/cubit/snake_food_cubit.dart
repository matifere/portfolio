import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';


class SnakeFoodCubit extends Cubit<List<int>> {
  SnakeFoodCubit() : super([Random().nextInt(900), Random().nextInt(900)]);

  void crearComida(int nivel) {
    for (var i = 0; i < nivel; i++) {
      state.add(Random().nextInt(900));
    }
    emit(state);
  }

  void comer(int comida){
    state.remove(comida);
    emit(state);
  }
  
}
