import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../firebase_options.dart';
import 'signup.dart';
import 'web_welcome_screen.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: WebApp()));
}

class WebApp extends StatelessWidget {
  const WebApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(colorSchemeSeed: Color.fromARGB(255, 95, 131, 229)),
      routes: {
        '/': (BuildContext context) => const WebWelcomeScreen(),
        '/signin': (BuildContext context) =>
            Signup(authFormType: AuthFormType.signin),
      },
    );
  }
}
