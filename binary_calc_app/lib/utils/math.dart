// Addition
String addBinary(String binary1, String binary2) {
  final RegExp binaryRegex = RegExp(r'^[01]*(\.[01]*)?$');
  if (binaryRegex.hasMatch(binary1) && binaryRegex.hasMatch(binary2)) {
    // Convert binary numbers to decimal
    double decimal1 = double.parse(binaryToDecimal(binary1));
    double decimal2 = double.parse(binaryToDecimal(binary2));
    // Addition
    double sum = decimal1 + decimal2;
    // Convert back to binary representation
    return formatBinaryResult(decimalToBinary(sum.toString()));
  } else {
    return 'Binary number can contain only: -, 0, 1, or a single dot';
  }
}

//_____________________________________________________________________________
// Subtraction
String subtractBinary(String binary1, String binary2) {
  final RegExp binaryRegex = RegExp(r'^[01]*(\.[01]*)?$');
  if (binaryRegex.hasMatch(binary1) && binaryRegex.hasMatch(binary2)) {
    // Convert binary numbers to decimal
    double decimal1 = double.parse(binaryToDecimal(binary1));
    double decimal2 = double.parse(binaryToDecimal(binary2));
    // Subtraction
    double difference = decimal1 - decimal2;
    // Convert back to binary representation
    return formatBinaryResult(decimalToBinary(difference.toString()));
  } else {
    return 'Binary number can contain only: -, 0, 1, or a single dot';
  }
}

//_____________________________________________________________________________
// Multiplication
String multBinary(String binary1, String binary2) {
  final RegExp binaryRegex = RegExp(r'^[01]*(\.[01]*)?$');
  if (binaryRegex.hasMatch(binary1) && binaryRegex.hasMatch(binary2)) {
    // Convert binary numbers to decimal
    double decimal1 = double.parse(binaryToDecimal(binary1));
    double decimal2 = double.parse(binaryToDecimal(binary2));
    // Multiplication
    double product = decimal1 * decimal2;
    // Convert back to binary representation
    return formatBinaryResult(decimalToBinary(product.toString()));
  } else {
    return 'Binary number can contain only: -, 0, 1, or a single dot';
  }
}

//_____________________________________________________________________________
// Division
String divideBinary(String binary1, String binary2) {
  final RegExp binaryRegex = RegExp(r'^[01]*(\.[01]*)?$');
  if (binaryRegex.hasMatch(binary1) && binaryRegex.hasMatch(binary2)) {
    // Convert binary numbers to decimal
    double decimal1 = double.parse(binaryToDecimal(binary1));
    double decimal2 = double.parse(binaryToDecimal(binary2));

    if (decimal2 == 0) {
      return 'Error: Division by zero';
    }
    // Division
    double quotient = decimal1 / decimal2;
    // Convert back to binary representation
    return formatBinaryResult(decimalToBinary(quotient.toString()));
  } else {
    return 'Binary number can contain only: -, 0, 1, or a single dot';
  }
}

//_____________________________________________________________________________
// Format the result to remove unnecessary trailing dot
String formatBinaryResult(String binary) {
  // Remove the trailing dot if it is at the end
  if (binary.endsWith('.')) {
    binary = binary.substring(0, binary.length - 1);
  }
  return binary;
}

//_____________________________________________________________________________
String binaryToDecimal(String value) {
  final RegExp binaryRegex = RegExp(
      r'^-?[01]+(\.[01]*)?$'); // Allow optional fractional part and optional negative sign

  if (binaryRegex.hasMatch(value)) {
    bool isNegative = value.startsWith('-');
    String valueWithoutSign = isNegative ? value.substring(1) : value;

    List<String> parts = valueWithoutSign.split('.');

    // Process integer part
    BigInt integerPart = BigInt.parse(parts[0], radix: 2);

    // Process fractional part
    double fractionalPart = 0;

    int maxFractionLength = 30; // Limit for fractional part length
    if (parts.length == 2 && parts[1].isNotEmpty) {
      String fractionalBinary = parts[1];
      int count = 0;

      for (int i = 0;
          i < fractionalBinary.length && count < maxFractionLength;
          i++) {
        if (fractionalBinary[i] == '1') {
          fractionalPart += 1 / (1 << (i + 1)); // 1 << (i + 1) means 2^(i + 1)
          count++;
        } else {
          count++;
        }
      }
    }

    // Combine integer and fractional parts
    double result = integerPart.toDouble() + fractionalPart;
    if (isNegative) {
      result = -result;
    }

    // Format the result, removing unnecessary trailing zeros and dot if the fractional part is zero
    String resultString = result.toString();
    if (resultString.contains('.')) {
      resultString = resultString.replaceAll(
          RegExp(r'0*$'), ''); // Remove all trailing zeros
      if (resultString.endsWith('.')) {
        resultString = resultString.substring(
            0, resultString.length - 1); // Remove dot if it is left at the end
      }
    }
    return resultString;
  } else {
    return 'Binary number can contain only: -, 0, 1, or a single dot';
  }
}

//_____________________________________________________________________________
String decimalToBinary(String value1) {
  // Check that input contains only digits, one dot, and an optional minus sign
  if (!RegExp(r'^-?[0-9]*\.?[0-9]*$').hasMatch(value1)) {
    return 'Input contains invalid characters.';
  }

  bool isNegative = value1.startsWith('-');
  String valueWithoutSign = isNegative ? value1.substring(1) : value1;

  List<String> parts = valueWithoutSign.split('.');

  // Handle case where integer part is empty
  String integerPartString = parts[0].isEmpty ? '0' : parts[0];

  // Process integer part
  BigInt integerPart;
  try {
    integerPart = BigInt.parse(integerPartString);
  } catch (e) {
    return 'Error parsing integer part.';
  }

  String binaryIntegerPart = integerPart.toRadixString(2);

  if (parts.length == 1 || parts[1].isEmpty) {
    // If there is no fractional part or the fractional part is empty
    return (isNegative ? '-' : '') + binaryIntegerPart;
  } else {
    // Process fractional part
    double fractionalPart = double.parse("0.${parts[1]}");
    String binaryFractionalPart = '';

    int maxFractionLength = 30; // Limit the length of the fractional part
    int count = 0;

    while (fractionalPart != 0 && count < maxFractionLength) {
      fractionalPart *= 2;
      if (fractionalPart >= 1) {
        binaryFractionalPart += '1';
        fractionalPart -= 1;
      } else {
        binaryFractionalPart += '0';
      }
      count++;
    }

    // Remove unnecessary dot at the end
    String result = binaryIntegerPart;
    if (binaryFractionalPart.isNotEmpty) {
      result += '.$binaryFractionalPart';
    }
    return (isNegative ? '-' : '') + formatBinaryResult(result);
  }
}
