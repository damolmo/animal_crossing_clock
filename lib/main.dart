import 'package:flutter/material.dart';
import 'package:animal_crossing_clock/exports.dart';
import 'package:flutter/services.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  @override
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp]);
    return MaterialApp(
      home: ClockScreenView(),
      debugShowCheckedModeBanner: false,

    );
  }
}