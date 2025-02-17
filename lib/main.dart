

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sipcalculator/sipscreen.dart';
import 'dart:math';

import 'emiscreen.dart'; // Import the dart:math library to use the pow function

void main(){
   runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SipCalculator(),
    );
  }
}
