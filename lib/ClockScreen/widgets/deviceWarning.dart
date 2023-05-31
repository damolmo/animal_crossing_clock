import 'dart:io';

import 'package:animal_crossing_clock/ClockScreen/clockScreen_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';

class DeviceWarning extends StatelessWidget{
  @override
  const DeviceWarning({
    super.key,
    required this.viewModel,
});

  final ClockScreenModel viewModel;

  @override
  Widget build(BuildContext context){

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          color: Colors.orangeAccent
        ),
        child: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          margin: EdgeInsets.only(
            top: height * 0.1,
            bottom: height * 0.1,
            left: width * 0.1,
            right: width * 0.1
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30)
          ),
          child: Container(
            width: width * 0.7,
            height: height * 0.7,
            margin: EdgeInsets.only(
              left: width * 0.05,
              right: width * 0.05,
              top: height * 0.05,
              bottom: height * 0.05
            ),
            child: Stack(
              children: [
                // App Logo
                AppLogo(viewModel: viewModel, height: height, width: width,),

                // Notification
                NotificationText(viewModel: viewModel, height: height, width: width),

                // Confirm Button
                CloseButton(viewModel: viewModel, width: width, height: height,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppLogo extends StatelessWidget{
  @override
   const AppLogo({
    required this.viewModel,
    required this.height,
    required this.width,
    super.key
});

  final ClockScreenModel viewModel;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context){
    return Container(
      width: width * 0.22,
      height: height * 0.15,
      margin: EdgeInsets.only(left: width * 0.24, right: width * 0.24),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/logo/logo.png"),
          fit: BoxFit.fitHeight
        )
      ),
    );
  }
}

class NotificationText extends StatelessWidget{
  @override
  const NotificationText({
    required this.viewModel,
    required this.height,
    required this.width,
    super.key
});

  final ClockScreenModel viewModel;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context){
    return Container(
      width: width * 0.5,
      height: height * 0.35,
      margin: EdgeInsets.only(
        top: height * 0.20,
        left: width * 0.10,
        right: width * 0.10
      ),
      child: ListView(
        children: [
          Text("Esta aplicación no es compatible con tu dispositivo, necesitas un dispositivo móvil para ejecutarla. Gracias por tu interés en 'Animal Crossing Clock'.", style: TextStyle(color: Colors.black, fontSize: width * 0.045, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
        ],
      ),
    );
  }
}

class CloseButton extends StatelessWidget{
  @override
  const CloseButton({
    required this.viewModel,
    required this.width,
    required this.height,
    super.key
});

  final ClockScreenModel viewModel;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context){
    return Container(
      width: width * 0.6,
      height: height * 0.1,
      margin: EdgeInsets.only(
        top: height * 0.6,
        left: width * 0.05,
        right: width * 0.05
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child : TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.blueAccent
          ),
          onPressed: (){
            FlutterExitApp.exitApp(iosForceExit: true);
      },
          child: const Text("Cerrar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 45), textAlign: TextAlign.center,),
        ),
      ),
    );
  }
}