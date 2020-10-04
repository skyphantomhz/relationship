import 'dart:async';

import 'package:flutter/material.dart';
import 'package:relationship/provider/locator.dart';
import 'package:relationship/screens/home/home_screen.dart';

void main() async {
  setupLocator();
  return runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}