import 'package:animal_crossing_clock/ClockScreen/widgets/backgroundTheme.dart';
import 'package:animal_crossing_clock/ClockScreen/widgets/deviceWarning.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import '../exports.dart';

class ClockScreenView extends StackedView<ClockScreenModel> {
  @override
  const ClockScreenView({super.key});

  @override
  Widget builder(
      BuildContext context,
      ClockScreenModel viewModel,
      Widget? child
      ){

    return Scaffold(
      body : Stack(
        children : [

          // Background Theme
          BackgroundTheme(viewModel: viewModel),

          // Path
          PathWidget(viewModel: viewModel),

          // Tree
          TreeWidget(viewModel: viewModel),

          // Clock
          ClockWidget(viewModel: viewModel),

          // Balloon
          if (viewModel.launchingBalloon)
            BalloonWidget(viewModel: viewModel),

          // Unlocked Characters
          NpcsTable(viewModel: viewModel),

          // Volume button for web
          if (kIsWeb)
          WebVolumeButton(viewModel: viewModel),

          // Device Warning
          if (MediaQuery.of(context).size.width > 500 )
          DeviceWarning(viewModel: viewModel),
        ]
      )
    );
  }

  @override
  ClockScreenModel viewModelBuilder(BuildContext context) => ClockScreenModel();
}