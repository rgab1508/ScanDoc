import 'package:flutter/material.dart';

import './pages/logo_screen.dart';

void main() {
  runApp(MaterialApp(
    title: "ScanDoc",
    theme: ThemeData(backgroundColor: Colors.white),
    initialRoute: 'logo_screen',
    routes: {
      'logo_screen': (context) => LogoScreen(),
    },
  ));
}
