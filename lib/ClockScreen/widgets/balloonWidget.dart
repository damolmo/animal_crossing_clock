import 'package:animal_crossing_clock/ClockScreen/clockScreen_model.dart';
import 'package:flutter/material.dart';

class BalloonWidget extends StatelessWidget{
  @override
  const BalloonWidget({
    required this.viewModel,
    super.key
});

  final ClockScreenModel viewModel;

  @override
  Widget build(BuildContext context){

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
        width: width * 0.2,
        height: height * 0.2,
        margin: EdgeInsets.only(
          top: height * 0.3,
          bottom: height * 0.5,
          left: width * viewModel.marginLeft,
          right: width * viewModel.marginRight
        ),
      child: InkWell(
        onTap : (){
          // Break the balloon
          viewModel.launchingBalloon = false;
          viewModel.balloonPlayer.pause();
          viewModel.balloonPlayer.stop();
          viewModel.notifyListeners();
          viewModel.addNpcToAchieved();
        },
        child : Image.asset(viewModel.currentBalloon.asset, fit: BoxFit.fitHeight,)
      ),
    );
  }
}