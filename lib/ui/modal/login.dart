import 'package:flavorsph/ui/Authentication/views/citizenSignup.dart';
import 'package:flutter/material.dart';

class LoginModal extends StatelessWidget {
  const LoginModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 85 / 100,
            padding:
                const EdgeInsets.only(left: 16, right: 16, bottom: 32, top: 16),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: CitizenSignup())
      ],
    );
  }
}
