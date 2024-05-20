import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flavorsph/adminweb/controllers/auth_controller.dart';
import 'package:flavorsph/adminweb/controllers/user_controller.dart';
import 'package:flavorsph/ui/views/page/myPageView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Consumer(builder: (context, ref, child) {
            final userController = ref.watch(userControllerProvider.notifier);

            return SignInScreen(
              actions: [
                AuthStateChangeAction<UserCreated>((context, state) async {
                  try {
                    print("STORING USER");
                    print(state.credential.user);

                    await userController.storeNewUser(
                        email: state.credential.user!.email,
                        role: 'client',
                        uid: state.credential.user!.uid);
                  } catch (e) {
                    print(e);
                  }
                }),
              ],
              providers: [
                EmailAuthProvider(),
              ],
            );
          });
        }
        return MyPageView();
      },
    );
  }
}
