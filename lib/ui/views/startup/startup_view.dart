import 'package:flavorsph/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({super.key});

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(body: const AuthGate());
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  // @override
  // void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
  //     .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
