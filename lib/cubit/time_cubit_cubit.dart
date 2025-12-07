import 'package:bloc/bloc.dart';

class TimeCubitCubit extends Cubit<String> {
  TimeCubitCubit() : super('');

  void update() {
    final now = DateTime.now();
    final formattedDate =
        '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}:${now.second}';
    emit(formattedDate);
    Future.delayed(const Duration(seconds: 1), update);
  }
}
