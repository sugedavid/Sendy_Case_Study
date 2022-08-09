import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sendy_case_study/presentation/LogInPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sendy',
      theme: _buildTheme(Brightness.light),
      home: LoginPage(),
    );
  }

  ThemeData _buildTheme(brightness) {
    var baseTheme = ThemeData(brightness: brightness);

    return baseTheme.copyWith(
      textTheme: GoogleFonts.nunitoTextTheme(baseTheme.textTheme),
    );
  }
}
