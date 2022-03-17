import 'package:ctlk2/pages/LandingPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

void main() async {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    setPrefs();

    return MaterialApp(
      title: 'Material App',
      home:LandingPage()
    );
  }

  setPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getInt("ct") == null) {
      prefs.setInt("ct", 0);
    } else {
      await prefs.setInt("ct", (prefs.getInt("ct")!) + 1);
    }

    print(prefs.getInt("ct"));
  }
}
