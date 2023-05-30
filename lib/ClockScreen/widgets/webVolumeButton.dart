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
    return IconButton(
      onPressed : (){
        if (viewModel.isMusicPlaying){
          viewModel.player.pause();
          viewModel.player.stop();
          viewModel.isMusicPlaying = false;
          viewModel.notifyListeners();
        } else {
          viewModel.playBackgroundMusic();
          viewModel.isMusicPlaying = true;
          viewModel.notifyListeners();
        }
      },
      icon: Icon(!viewModel.isMusicPlaying ? Icons.volume_off_rounded :  Icons.volume_up_rounded, color: Colors.white, size: 25, ),

    );
  }


}