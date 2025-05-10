import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Import the HomeScreen widget

void main() {
  runApp(MyApp()); // This starts the app
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(), // HomeScreen is the first screen of the app
    );
  }
}
