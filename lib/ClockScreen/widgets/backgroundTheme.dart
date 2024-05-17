import 'package:flutter/src/scheduler/ticker.dart';
import 'package:stacked/stacked.dart';
import '../../exports.dart';
import 'package:flutter/material.dart';

class BackgroundTheme extends StatefulWidget {
  @override
  const BackgroundTheme({
    required this.viewModel,
    super.key,
  });

  final ClockScreenModel viewModel;

  @override
  BackgroundThemeState createState() => BackgroundThemeState(viewModel: viewModel);

}

class BackgroundThemeState extends State<BackgroundTheme> with TickerProviderStateMixin{

  @override
  BackgroundThemeState({
    required this.viewModel
});

  final ClockScreenModel viewModel;

  @override
  void initState(){
    animateBackground();
    super.initState();
  }


  // Values used for disc rotation
  late AnimationController _controller;
  late Animation<Offset> _animation;
  final Tween<double> turnsTween = Tween<double>(
    begin: 0,
    end: 1,
  );

  @override
  void initialise(){
    animateBackground();
  }

  animateBackground() async {
    _controller=AnimationController(vsync:this,duration: const Duration(seconds: 80));
    _animation= Tween<Offset>(begin: const Offset(0.3,0.0), end: Offset.zero).animate(_controller);
    _controller.forward().whenComplete((){
      _controller.repeat();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context){

    return OverflowBox(
      maxWidth: MediaQuery.of(context).size.width *  4.0,
      maxHeight: MediaQuery.of(context).size.height * 4.0 ,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
        SlideTransition(
            position: _animation,
        child: AnimatedContainer(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(viewModel.isTotakaPlaying ? "assets/sky/totakeke.jpeg" : viewModel.currentTime.sky),
                fit: BoxFit.fitWidth
            ),
          ), duration: const Duration(seconds: 0),
        )
        )
        ],
      ),
    );
  }

}