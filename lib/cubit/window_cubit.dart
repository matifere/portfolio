import 'package:bloc/bloc.dart';
import 'package:portfolio/window_widget.dart';

class WindowCubit extends Cubit<List<WindowWidget>> {
  WindowCubit() : super([]);

  List<WindowWidget> minimizedWindows = [];

  void addWindow(WindowWidget window) {
    final newList = List<WindowWidget>.from(state)..add(window);
    emit(newList);
  }

  void removeWindow(String id) {
    final newList = List<WindowWidget>.from(state);
    newList.removeWhere((w) => w.window.id == id);
    emit(newList);
  }

  void focusWindow(String id) {
    final newList = List<WindowWidget>.from(state);
    newList.removeWhere((w) => w.window.id == id);
    newList.add(state.firstWhere((w) => w.window.id == id));
    emit(newList);
  }

  void minimizeWindow(String id) {
    final window = state.firstWhere((w) => w.window.id == id);
    minimizedWindows.add(window);

    final newList = List<WindowWidget>.from(state);
    newList.removeWhere((w) => w.window.id == id);
    emit(newList);
  }

  void maximizeWindow(String id) {
    final window = minimizedWindows.firstWhere((w) => w.window.id == id);
    minimizedWindows.removeWhere((w) => w.window.id == id);

    final newList = List<WindowWidget>.from(state)..add(window);
    emit(newList);
  }

  List<String> getAllWindows() {
    return state.map((w) => w.window.id).toList()
      ..addAll(minimizedWindows.map((w) => w.window.id));
  }
}
