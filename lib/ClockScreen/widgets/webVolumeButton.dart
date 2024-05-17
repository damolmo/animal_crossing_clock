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
        try {
          viewModel.player.pause();
          viewModel.player.release();
          viewModel.playBackgroundMusic();
        } catch (e){
          viewModel.playBackgroundMusic();
        }

      },
      icon: Icon(!viewModel.isMusicPlaying ? Icons.volume_off_rounded :  Icons.volume_up_rounded, color: Colors.white, size: 25, ),

    );
  }


}