class ConversionUtils {
  // Main conversion method that handles all unit conversions
  static double convert(double value, String fromUnit, String toUnit) {
    // If units are the same, no conversion needed
    if (fromUnit == toUnit) {
      return value;
    }

    // Distance conversions
    if (_isDistanceUnit(fromUnit) && _isDistanceUnit(toUnit)) {
      return _convertDistance(value, fromUnit, toUnit);
    }

    // Weight conversions
    if (_isWeightUnit(fromUnit) && _isWeightUnit(toUnit)) {
      return _convertWeight(value, fromUnit, toUnit);
    }

    // Temperature conversions
    if (_isTemperatureUnit(fromUnit) && _isTemperatureUnit(toUnit)) {
      return _convertTemperature(value, fromUnit, toUnit);
    }

    // If no suitable conversion found
    return 0.0;
  }

  // Helper methods to determine unit category
  static bool _isDistanceUnit(String unit) {
    return [
      'Miles',
      'Kilometers',
      'Meters',
      'Centimeters',
      'Inches',
      'Feet',
    ].contains(unit);
  }

  static bool _isWeightUnit(String unit) {
    return ['Pounds', 'Kilograms', 'Grams', 'Ounces', 'Tons'].contains(unit);
  }

  static bool _isTemperatureUnit(String unit) {
    return ['Fahrenheit', 'Celsius', 'Kelvin'].contains(unit);
  }

  // DISTANCE CONVERSIONS
  static double _convertDistance(double value, String fromUnit, String toUnit) {
    // First convert to meters (our base unit for distance)
    double meters = _convertToMeters(value, fromUnit);

    // Then convert from meters to target unit
    return _convertFromMeters(meters, toUnit);
  }

  static double _convertToMeters(double value, String fromUnit) {
    switch (fromUnit) {
      case 'Miles':
        return value * 1609.34;
      case 'Kilometers':
        return value * 1000;
      case 'Meters':
        return value;
      case 'Centimeters':
        return value / 100;
      case 'Inches':
        return value * 0.0254;
      case 'Feet':
        return value * 0.3048;
      default:
        return 0;
    }
  }

  static double _convertFromMeters(double meters, String toUnit) {
    switch (toUnit) {
      case 'Miles':
        return meters / 1609.34;
      case 'Kilometers':
        return meters / 1000;
      case 'Meters':
        return meters;
      case 'Centimeters':
        return meters * 100;
      case 'Inches':
        return meters / 0.0254;
      case 'Feet':
        return meters / 0.3048;
      default:
        return 0;
    }
  }

  // Original conversion functions from the example
  static double milesToKilometers(double miles) {
    return miles * 1.60934;
  }

  static double kilometersToMiles(double kilometers) {
    return kilometers / 1.60934;
  }

  // WEIGHT CONVERSIONS
  static double _convertWeight(double value, String fromUnit, String toUnit) {
    // First convert to grams (our base unit for weight)
    double grams = _convertToGrams(value, fromUnit);

    // Then convert from grams to target unit
    return _convertFromGrams(grams, toUnit);
  }

  static double _convertToGrams(double value, String fromUnit) {
    switch (fromUnit) {
      case 'Pounds':
        return value * 453.592;
      case 'Kilograms':
        return value * 1000;
      case 'Grams':
        return value;
      case 'Ounces':
        return value * 28.3495;
      case 'Tons':
        return value * 907185;
      default:
        return 0;
    }
  }

  static double _convertFromGrams(double grams, String toUnit) {
    switch (toUnit) {
      case 'Pounds':
        return grams / 453.592;
      case 'Kilograms':
        return grams / 1000;
      case 'Grams':
        return grams;
      case 'Ounces':
        return grams / 28.3495;
      case 'Tons':
        return grams / 907185;
      default:
        return 0;
    }
  }

  // Original conversion functions from the example
  static double poundsToKilograms(double pounds) {
    return pounds * 0.453592;
  }

  static double kilogramsToPounds(double kilograms) {
    return kilograms / 0.453592;
  }

  // TEMPERATURE CONVERSIONS
  static double _convertTemperature(
    double value,
    String fromUnit,
    String toUnit,
  ) {
    // For temperature, we need specific conversions between each unit pair
    if (fromUnit == 'Fahrenheit' && toUnit == 'Celsius') {
      return fahrenheitToCelsius(value);
    } else if (fromUnit == 'Celsius' && toUnit == 'Fahrenheit') {
      return celsiusToFahrenheit(value);
    } else if (fromUnit == 'Celsius' && toUnit == 'Kelvin') {
      return value + 273.15;
    } else if (fromUnit == 'Kelvin' && toUnit == 'Celsius') {
      return value - 273.15;
    } else if (fromUnit == 'Fahrenheit' && toUnit == 'Kelvin') {
      // First convert to Celsius, then to Kelvin
      return fahrenheitToCelsius(value) + 273.15;
    } else if (fromUnit == 'Kelvin' && toUnit == 'Fahrenheit') {
      // First convert to Celsius, then to Fahrenheit
      return celsiusToFahrenheit(value - 273.15);
    }

    return value; // Default case
  }

  // Original conversion functions from the example
  static double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  static double celsiusToFahrenheit(double celsius) {
    return (celsius * 9 / 5) + 32;
  }
}
