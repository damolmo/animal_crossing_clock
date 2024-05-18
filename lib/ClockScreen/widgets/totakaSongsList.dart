import 'package:flutter/material.dart';
import '../../exports.dart';

class TotakaSongsList extends StatelessWidget{
  @override
  TotakaSongsList({
    required this.viewModel,
    super.key
});

  final ClockScreenModel viewModel;

  @override
  Widget build(BuildContext context){
    return Container(
      width: getDeviceWidth(context) > 580 ?  getDeviceWidth(context) *  0.45 : getDeviceWidth(context) *  0.95,
      height: getDeviceHeight(context) * 0.95,
      margin: EdgeInsets.only(
        left: getDeviceWidth(context) > 580 ?  getDeviceWidth(context) *  0.275 :  getDeviceWidth(context) *  0.025,
        right: getDeviceWidth(context) > 580 ?  getDeviceWidth(context) *  0.275 :  getDeviceWidth(context) * 0.025,
        top: getDeviceHeight(context) *  0.025,
        bottom: getDeviceHeight(context) * 0.025
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.black.withOpacity(0.8),
        boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.3), spreadRadius: 3.0, blurRadius: 89.0, blurStyle: BlurStyle.normal)]
      ),
      child: ListView.builder(
          itemCount: viewModel.songs.length,
          itemBuilder: (context, index){
            return Container(
              width: getDeviceWidth(context) > 580 ?  getDeviceWidth(context) *  0.4 :  getDeviceWidth(context) * 0.9,
              height: getDeviceHeight(context) *  0.1,
              margin: EdgeInsets.only(
                left: getDeviceWidth(context) * 0.025,
                right: getDeviceWidth(context) * 0.025,
                top: getDeviceHeight(context) * 0.025,
                bottom: viewModel.songs.length - 1 == index ? getDeviceHeight(context) *  0.05 : 0.0
              ),
              decoration: BoxDecoration(
                color: viewModel.choosedSongIndex ==  index && viewModel.isTotakaPlaying ? Colors.white.withOpacity(0.89) : Colors.orange.withOpacity(0.89),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [BoxShadow(color: Colors.white.withOpacity(0.6), blurStyle: BlurStyle.normal, blurRadius: 6.0, spreadRadius: 3.0)]
              ),
              child: ListTile(
                leading: Container(width : getDeviceWidth(context) > 580 ?  getDeviceWidth(context) *  0.07 :  getDeviceWidth(context) * 0.15, height: getDeviceWidth(context) > 580 ?  getDeviceHeight(context) *  0.05 :  getDeviceHeight(context) *  0.1, decoration : BoxDecoration(borderRadius: BorderRadius.circular(360), image: DecorationImage(image: AssetImage(viewModel.songs[index].songBoxart)))),
                title: Text(viewModel.songs[index].songName, style: TextStyle(color: viewModel.choosedSongIndex == index && viewModel.isTotakaPlaying ? Colors.black :  Colors.white, fontSize: getDeviceWidth(context) > 580 ?  getDeviceWidth(context) *  0.03 :  getDeviceWidth(context) * 0.05, fontWeight: FontWeight.bold),),
                subtitle: Text(viewModel.choosedSongIndex == index && viewModel.isTotakaPlaying ? "${viewModel.currentDuration}/${viewModel.totalDuration}" : "", style: TextStyle(color: viewModel.choosedSongIndex == index ? Colors.black : Colors.white, fontSize: getDeviceWidth(context) * 0.04 ),),
                trailing: IconButton(
                  onPressed : (){
                    if (viewModel.choosedSongIndex == index ){
                      viewModel.isTotakaPlaying ?  viewModel.isTotakaPlaying = false : viewModel.isTotakaPlaying = true;
                      viewModel.choosedSongIndex = index;
                      viewModel.isTotakaMenu = false;
                      viewModel.notifyListeners();
                      viewModel.playChoosedTotakaSong(viewModel.isTotakaPlaying);
                    } else {
                      viewModel.isTotakaPlaying = true;
                      viewModel.choosedSongIndex = index;
                      viewModel.isTotakaMenu = false;
                      viewModel.notifyListeners();
                      viewModel.playChoosedTotakaSong(viewModel.isTotakaPlaying);
                    }

                  },

                  icon : Icon(viewModel.choosedSongIndex == index && viewModel.isTotakaPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, color: viewModel.choosedSongIndex == index  && viewModel.isTotakaPlaying? Colors.black : Colors.white, size: 45,)
                ),

              ),
            );
            },
      )
    );
  }

}