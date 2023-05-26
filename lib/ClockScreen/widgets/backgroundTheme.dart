import '../../exports.dart';
import 'package:flutter/material.dart';

class BackgroundTheme extends StatelessWidget {
  @override
  const BackgroundTheme({
    required this.viewModel,
    super.key
});

  final ClockScreenModel viewModel;

  @override
  Widget build(BuildContext context){

    final width = MediaQuery.of(context).size.width;

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(viewModel.currentTime.sky),
          fit: width > 800 ? BoxFit.fill : BoxFit.fitHeight
        )
      ),
    );
  }
}