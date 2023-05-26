import '../../exports.dart';
import 'package:flutter/material.dart';

class TreeWidget extends StatelessWidget{
  @override
  const TreeWidget({
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
      height: height * 0.45,
      margin: EdgeInsets.only(
        top: height * 0.3,
        bottom: height * 0.1,
        left: width * 0.1,
        right: width * 0.1
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(viewModel.currentStation.tree),
          fit: BoxFit.fitHeight
        )
      ),
    );
  }

}