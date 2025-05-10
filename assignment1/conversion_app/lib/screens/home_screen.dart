import 'package:flutter/material.dart';
import '../utils/conversion_utils.dart'; // Import the conversion utils

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Variables to store user input
  double inputValue = 0.0;
  double convertedValue = 0.0;

  // Default unit selections
  String inputUnit = 'Miles';
  String outputUnit = 'Kilometers';

  // All available units organized by category
  final Map<String, List<String>> unitsByCategory = {
    'Distance': [
      'Miles',
      'Kilometers',
      'Meters',
      'Centimeters',
      'Inches',
      'Feet',
    ],
    'Weight': ['Pounds', 'Kilograms', 'Grams', 'Ounces', 'Tons'],
    'Temperature': ['Fahrenheit', 'Celsius', 'Kelvin'],
  };

  // Flat list of all units for the first dropdown
  late List<String> allUnits;

  @override
  void initState() {
    super.initState();
    // Create a flat list of all units
    allUnits = [];
    unitsByCategory.forEach((category, unitList) {
      allUnits.addAll(unitList);
    });
  }

  // Function to handle conversions using conversion_utils.dart
  void convert() {
    setState(() {
      if (inputUnit == outputUnit) {
        convertedValue = inputValue;
        return;
      }

      // Use the ConversionUtils for all conversions
      convertedValue = ConversionUtils.convert(
        inputValue,
        inputUnit,
        outputUnit,
      );
    });
  }

  // Get the category a unit belongs to
  String _getCategoryForUnit(String unit) {
    for (var entry in unitsByCategory.entries) {
      if (entry.value.contains(unit)) {
        return entry.key;
      }
    }
    return 'Distance'; // Default fallback
  }

  // Get all compatible units for a given input unit
  List<String> _getCompatibleUnits(String unit) {
    String category = _getCategoryForUnit(unit);
    return unitsByCategory[category] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Measurement Converter'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Input value field with label
              Text(
                'Value',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  hintText: 'Enter a number',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.0),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                      width: 2.0,
                    ),
                  ),
                ),
                onChanged: (String value) {
                  setState(() {
                    inputValue = double.tryParse(value) ?? 0.0;
                    convertedValue = 0.0;
                  });
                },
              ),
              SizedBox(height: 20),

              // From unit selection
              Text(
                'Convert From',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButton<String>(
                isExpanded: true,
                value: inputUnit,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      String oldCategory = _getCategoryForUnit(inputUnit);
                      String newCategory = _getCategoryForUnit(newValue);

                      inputUnit = newValue;

                      // If category changed, update output unit
                      if (oldCategory != newCategory) {
                        // Find all compatible units
                        List<String> compatibleUnits = _getCompatibleUnits(
                          inputUnit,
                        );
                        // Select a different unit if possible
                        if (compatibleUnits.contains(outputUnit)) {
                          // Keep the same output if compatible
                        } else if (compatibleUnits.length > 1) {
                          // Select first different unit as output
                          for (String unit in compatibleUnits) {
                            if (unit != inputUnit) {
                              outputUnit = unit;
                              break;
                            }
                          }
                        } else if (compatibleUnits.isNotEmpty) {
                          // If only one unit in category, use it
                          outputUnit = compatibleUnits[0];
                        }
                      }

                      convertedValue = 0.0;
                    });
                  }
                },
                items:
                    allUnits.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              ),
              SizedBox(height: 20),

              // To unit selection
              Text(
                'Convert To',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              DropdownButton<String>(
                isExpanded: true,
                value: outputUnit,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      outputUnit = newValue;
                      convertedValue = 0.0;
                    });
                  }
                },
                items:
                    _getCompatibleUnits(
                      inputUnit,
                    ).map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
              ),
              SizedBox(height: 20),

              // Button to perform the conversion
              Center(
                child: ElevatedButton(
                  onPressed: convert,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    'Convert',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Display the result of the conversion
              Center(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Result',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '${inputValue.toStringAsFixed(2)} $inputUnit = ${convertedValue.toStringAsFixed(2)} $outputUnit',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
