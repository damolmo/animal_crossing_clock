import '../../exports.dart';
import 'package:flutter/material.dart';

class PathWidget extends StatelessWidget{
  @override
  const PathWidget({
    required this.viewModel,
    super.key
});

  final ClockScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.maxFinite,
      height: height * 0.3,
      margin: EdgeInsets.only(top: height * 0.7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: width > 800 ? Radius.circular(800) : Radius.circular(170),
          topRight: width > 800 ? Radius.circular(800) :Radius.circular(170)
        ),
        image: DecorationImage(
          image: AssetImage(viewModel.currentStation.path),
          fit: BoxFit.fitWidth,
        )
      ),
    );
  }

}