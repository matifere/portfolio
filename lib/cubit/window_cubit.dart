import 'package:bloc/bloc.dart';
import 'package:portfolio/window_widget.dart';

class WindowCubit extends Cubit<List<WindowWidget>> {
  WindowCubit() : super([]);

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
}
