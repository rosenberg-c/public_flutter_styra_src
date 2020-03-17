import 'package:flutter_styra/shared/functions/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("$generateIntList generate number list 1", () {
    final result = generateIntList(start: 1, length: 10, steps: 10);
    expect(result, [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]);
  });

  test("$generateWeights generate number list 2", () {
    final result = generateWeights();
    expect(result, [
      100,
      150,
      200,
      250,
      300,
      350,
      400,
      450,
      500,
      550,
      600,
      650,
      700,
      750,
      800,
      850,
      900,
      950
    ]);
  });
}
