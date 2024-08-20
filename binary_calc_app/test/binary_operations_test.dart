import 'package:flutter_test/flutter_test.dart';
import 'package:binary_calc_app/utils/math.dart'; // Замените на правильный импорт вашего файла с функциями

void main() {
  group('Binary Operations', () {
    test('Addition of binary numbers', () {
      String result = addBinary('101', '110');
      expect(result, '1011'); // 5 + 6 = 11
    });

    test('Subtraction of binary numbers', () {
      String result = subtractBinary('110', '101');
      expect(result, '1'); // 6 - 5 = 1
    });

    test('Multiplication of binary numbers', () {
      String result = multBinary('101', '10');
      expect(result, '1010'); // 5 * 2 = 10
    });

    test('Division of binary numbers', () {
      String result = divideBinary('1010', '10');
      expect(result, '101'); // 10 / 2 = 5
    });

    test('Division by zero', () {
      String result = divideBinary('1010', '0');
      expect(result, 'Error: Division by zero');
    });

    test('Convert', () {
      String result = binaryToDecimal('0');
      expect(result, '0');
    });

    test('Convert', () {
      String result = binaryToDecimal('0.11');
      expect(result, '0.75');
    });
    test('Convert', () {
      String result = binaryToDecimal('10');
      expect(result, '2');
    });
    test('Convert', () {
      String result = binaryToDecimal('10.11');
      expect(result, '2.75');
    });
    test('Convert', () {
      String result = binaryToDecimal('1000.1');
      expect(result, '8.5');
    });

    test('Convert', () {
      String result = decimalToBinary('0');
      expect(result, '0');
    });
    test('Convert', () {
      String result = decimalToBinary('2');
      expect(result, '10');
    });
    test('Convert', () {
      String result = decimalToBinary('3.5');
      expect(result, '11.1');
    });
    test('Convert', () {
      String result = decimalToBinary('11.05');
      expect(result, '1011.000011001100110011001100110011');
    });
    test('Convert', () {
      String result = decimalToBinary('555');
      expect(result, '1000101011');
    });
  });
}
