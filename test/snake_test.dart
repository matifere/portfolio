import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio/cubit/snake_cubit.dart';

void main() {
  test("Esta en los limites", () {
    final bool enLimites = SnakeCubit().offLimits([2, 3, 4, 5, 6]);
    expect(enLimites, false);
  });
  test("fuera de los limites", () {
    final bool sinLimites = SnakeCubit().offLimits([
      25,
      26,
      27,
      28,
      29,
      30,
    ]);
    expect(sinLimites, true);
  });

  test('viene de algun lugar vertical', () {
    final bool pasoUno = SnakeCubit().offLimits([466, 496, 497, 498, 499]);
    expect(pasoUno, false);
    final bool paso2 = SnakeCubit().offLimits([496, 497, 498, 499, 500]);
    expect(paso2, false);
  });
}
