import '../../exports.dart';
import 'package:flutter/material.dart';

class WebVolumeButton extends StatelessWidget{
  @override
  const WebVolumeButton({
    required this.viewModel,
    super.key
  });

  final ClockScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      height: getDeviceHeight(context) * 0.1,
      width: getDeviceWidth(context) * 0.1,
      margin: EdgeInsets.only(
        top: getDeviceHeight(context) * 0.05,
        bottom: getDeviceHeight(context) * 0.85,
        right: getDeviceWidth(context) * 0.9
      ),
        child : IconButton(
          onPressed : (){
            viewModel.resumeMusic();
          },
          icon: Icon(!viewModel.isMusicPlaying ? Icons.volume_off_rounded :  Icons.volume_up_rounded, color: Colors.white, size: 35, ),
        ),
    );
  }


}