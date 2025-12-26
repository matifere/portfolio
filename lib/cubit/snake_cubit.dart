import 'package:flutter_bloc/flutter_bloc.dart';

class SnakeCubit extends Cubit<List<int>> {
  SnakeCubit() : super([121, 122, 123, 124, 125]);

  bool breaker = false;
  String previousDirection = "";

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
    if (isClosed) return;

    List<int> newState = List.from(state);
    switch (direction) {
      case "up":
        newState.removeAt(0);
        newState.add(state.last - rows);
        break;
      case "down":
        newState.removeAt(0);
        newState.add(state.last + rows);
        break;
      case "left":
        newState.removeAt(0);
        newState.add(state.last - 1);
        break;
      case "right":
        newState.removeAt(0);
        newState.add(state.last + 1);
        break;
      default:
    }

    if (offLimits(newState)) return;

    emit(newState);
    previousDirection = direction;

    await Future.delayed(const Duration(milliseconds: 100));
    _moveLoop(direction, rows, moveId);
  }

  //  ! si la cabeza mod largo = 0 y el anterior mod largo = largo-1 entonces el snake choco contra una pared
  /*
    _ _ _ _ _
    _ _ _ o o
    o _ _ _ _
   */
  // en el ejemplo se ve un snake [8,9,10] en un espacio con largo 5, tiene que devolver true
  // ? vamos a pensar de la misma manera el resto de las colisiones ya que el ejemplo solo sirve para la pared der
  // * Esto se hace en O(1)

  bool offLimits(List<int> newState) {
    return
    //pared der
    newState[newState.length - 1] % 30 == 0 &&
            newState[newState.length - 2] % 30 == 29 ||
        //pared izq
        newState[newState.length - 1] % 30 == 29 &&
            newState[newState.length - 2] % 30 == 0 ||
        //abajo
        newState[newState.length - 1] >= 900 ||
        //arriba
        newState[newState.length - 1] <= -1;
  }

  void stop() {
    breaker = !breaker;
  }

  void comer(int comida) {
    state.add(comida);
  }

  void reset() {
    emit([121, 122, 123, 124, 125]);
    previousDirection = "";
    _currentMoveId = 0;
    breaker = false;
  }
}
