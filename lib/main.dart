import 'package:flutter/material.dart';

import './pages/logo_screen.dart';
import './pages/scan_screen.dart';
import './pages/home_screen.dart';
import './pages/result_screen.dart';

void main() {
  runApp(MaterialApp(
    title: "ScanDoc",
    theme: ThemeData(backgroundColor: Colors.white),
    initialRoute: 'scan_screen',
    routes: {
      'logo_screen': (context) => LogoScreen(),
      'scan_screen': (context) => ScanScreen(),
      'result_screen': (context) => ResultScreen(),
      'home_screen': (context) => HomeScreen(),
    },
  ));
}
