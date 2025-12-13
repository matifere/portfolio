import 'package:flutter_bloc/flutter_bloc.dart';

class SnakeCubit extends Cubit<List<int>> {
  SnakeCubit() : super([121, 122, 123, 124, 125]);

  bool breaker = false;
  String previousDirection = "";

  /*
   ! revelacion magica a las 3AM: todos los movimientos se pueden hacer en O(1)
   ? vamos a quitar el tail y agregar el head, el resto de los valores siguen igual en la interaccion
  */

  int _currentMoveId = 0;

  void moveSnake(String direction, int rows) {
    if (breaker) return;

    if (direction == "up" && previousDirection == "down") return;
    if (direction == "down" && previousDirection == "up") return;
    if (direction == "left" && previousDirection == "right") return;
    if (direction == "right" && previousDirection == "left") return;

    _currentMoveId++;
    _moveLoop(direction, rows, _currentMoveId);
  }

  Future<void> _moveLoop(String direction, int rows, int moveId) async {
    if (moveId != _currentMoveId) return;

    List<int> newState = List.from(state);
    switch (direction) {
      case "up":
        newState.removeLast();
        newState.insert(0, state[0] - rows);
        break;
      case "down":
        newState.removeLast();
        newState.insert(0, state[0] + rows);
        break;
      case "left":
        newState.removeLast();
        newState.insert(0, state[0] - 1);
        break;
      case "right":
        newState.removeLast();
        newState.insert(0, state[0] + 1);
        break;
      default:
    }

    emit(newState);
    previousDirection = direction;

    await Future.delayed(const Duration(milliseconds: 100));
    _moveLoop(direction, rows, moveId);
  }

  void stop() {
    breaker = !breaker;
  }
}
