import 'package:flutter/material.dart';
import 'package:playground/screens/home_screen.dart';

main() => runApp(ComplexUIApp());

class ComplexUIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomeScreen(),
    );
  }
}
