import 'package:flutter/material.dart';
import '../../exports.dart';

class CurrentSongDialog extends StatelessWidget{
  @override
  const CurrentSongDialog({
    required this.viewModel,
    super.key
});

  final ClockScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap : (){
        viewModel.isTotakaMenu = true;
        viewModel.notifyListeners();
      },
        child : Container(
          width: getDeviceWidth(context) * 0.4,
          height: getDeviceHeight(context) *  0.05,
          margin: EdgeInsets.only(
            top: getDeviceHeight(context) * 0.5,
            bottom: getDeviceHeight(context) * 0.35,
            left: getDeviceWidth(context) *  0.3,
            right: getDeviceWidth(context) * 0.3
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.6), blurRadius: 30.0, spreadRadius: 3.0, blurStyle: BlurStyle.normal)]
          ),
          child: Row(
            children: [
              // Song Icon
              Container(
                width: getDeviceWidth(context) * 0.1,
                height: getDeviceHeight(context) * 0.05,
                margin: EdgeInsets.only(
                  left: getDeviceWidth(context) * 0.01,
                  right: getDeviceWidth(context) * 0.025
                ),
                child: Column(
                  children: [
                    const Spacer(),
                    const Icon(Icons.music_note_rounded, color: Colors.black, size: 25,),
                    const Spacer(),
                  ],
                ) ),

              // Song Name
              Container(
                width: getDeviceWidth(context) * 0.2,
                height: getDeviceHeight(context) *  0.05,
                margin: EdgeInsets.only(
                  right: getDeviceWidth(context) * 0.025
                ),
                child: Column(
                  children: [
                    const Spacer(),
                    Text(viewModel.songs[viewModel.choosedSongIndex].songName, style: TextStyle(color: Colors.black, fontSize: getDeviceWidth(context) * 0.03, fontWeight: FontWeight.bold),),
                    const Spacer(),
                  ],
                )
              )
            ],
          ),
        ),
    );
  }

}