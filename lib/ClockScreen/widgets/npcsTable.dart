import 'package:flutter/material.dart';
import '../../exports.dart';

class NpcsTable extends StatelessWidget{
  @override
  const NpcsTable({
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
      height: height * 0.4,
      margin: EdgeInsets.only(
        top: height * 0.55,
        bottom: height * 0.05,
        left: width * 0.05,
        right: width * 0.05),
      child: Stack(
        children: [
          // Aldeano
          if (viewModel.npcName.contains("aldeano"))
            Container(
              width: width * 0.45,
              height: height * 0.25,
              margin: EdgeInsets.only(
                right: width * 0.55,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(viewModel.npcs[viewModel.npcsString.indexOf("aldeano")].picture),
                    fit: BoxFit.fitWidth
                )
              ),
            ),

          // Totakeke
          if (viewModel.npcName.contains("totakeke"))
            Container(
              width: width * 0.4,
              height: height * 0.25,
              margin: EdgeInsets.only(
                  left: width * 0.3,
                  right: width * 0.3
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(viewModel.npcs[viewModel.npcsString.indexOf("totakeke")].picture),
                      fit: BoxFit.fitWidth
                  )
              ),
            ),

          // Canela
          if (viewModel.npcName.contains("canela"))
            Container(
              width: width * 0.3,
              height: height * 0.25,
              margin: EdgeInsets.only(
                  left: width * 0.65,
                  right: width * 0.05
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(viewModel.npcs[viewModel.npcsString.indexOf("canela")].picture),
                      fit: BoxFit.fitWidth
                  )
              ),
            ),

          // Tendo - Nendo
          if (viewModel.npcName.contains("tendo_nendo"))
            Container(
              width: width * 0.45,
              height: height * 0.25,
              margin: EdgeInsets.only(
                  top: height * 0.25,
                  left: width * 0.2,
                  right: width * 0.2
              ),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(viewModel.npcs[viewModel.npcsString.indexOf("tendo_nendo")].picture),
                    fit: BoxFit.fitWidth
                  )
              ),
            )
        ],
      ),
    );
  }
}