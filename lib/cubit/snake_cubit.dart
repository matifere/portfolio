import 'package:flutter_bloc/flutter_bloc.dart';

class SnakeCubit extends Cubit<List<int>> {
  SnakeCubit() : super([121, 122, 123, 124, 125]);

  bool breaker = false;
  String previousDirection = "";

  int _currentMoveId = 0;

  // TODO: agregar limites del mapa

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

    if (_offLimitsHorizontal(newState)) return;

    emit(newState);
    previousDirection = direction;

    await Future.delayed(const Duration(milliseconds: 100));
    _moveLoop(direction, rows, moveId);
  }

  // TODO terminar esto
  bool _offLimitsHorizontal(List<int> newState) {
    int getRow = newState.first ~/ 10;
    for (int i = 0; i < newState.length; i++) {
      if (newState[i] ~/ 10 != getRow) return true;
    }
    return false;
  }

  void stop() {
    breaker = !breaker;
  }

  void reset() {
    emit([121, 122, 123, 124, 125]);
    previousDirection = "";
    _currentMoveId = 0;
    breaker = false;
  }
}
