import 'package:feedback/feedback.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flavorsph/app/app.bottomsheets.dart';
import 'package:flavorsph/app/app.dialogs.dart';
import 'package:flavorsph/app/app.locator.dart';
import 'package:flavorsph/app/app.router.dart';
import 'package:flavorsph/ui/feedback/custom_feedback.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked_services/stacked_services.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  runApp(ProviderScope(
      child: BetterFeedback(
          feedbackBuilder: (context, onSubmit, scrollController) =>
              CustomFeedbackForm(
                  onSubmit: onSubmit, scrollController: scrollController),
          child: MainApp())));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipinoy',
      theme:
          ThemeData(colorSchemeSeed: const Color.fromARGB(255, 15, 150, 132)),
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
