// ignore_for_file: must_be_immutable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'controllers/auth_controller.dart';
import 'controllers/user_controller.dart';

enum AuthFormType { signin, signup, reset }

class Signup extends ConsumerStatefulWidget {
  AuthFormType? authFormType;
  Signup({super.key, required this.authFormType});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  final formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _firstName;
  String? _lastName;
  String? _error;
  bool _loader = false;

  void switchFormState(String state) {
    formKey.currentState!.reset();
    if (state == "signup") {
      setState(() {
        widget.authFormType = AuthFormType.signup;
      });
    } else {
      setState(() {
        widget.authFormType = AuthFormType.signin;
      });
    }
  }

  bool validate() {
    final form = formKey.currentState;
    form!.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    final authProvider = ref.watch(authControllerProvider.notifier);
    final userProvider = ref.watch(userControllerProvider.notifier);
    setState(() {
      _loader = true;
    });
    if (validate()) {
      try {
        if (widget.authFormType == AuthFormType.signin) {
          print('login in');
          String? uid = await authProvider.signInWithEmailAndPassword(
              email: _email!, password: _password!);
          print("Signed in with ID $uid");
        } else if (widget.authFormType == AuthFormType.reset) {
          print('password update');
          await authProvider.sendPasswordResetEmail(email: _email!);
          setState(() {
            widget.authFormType = AuthFormType.signin;
          });
        } else {
          print('creating account');
          String? uid = await authProvider.createUserWithEmailAndPassword(
              email: _email!, password: _password!);
          print("Signed up with new ID $uid");
          String role = "admin";
          await userProvider.storeNewUser(
              firstName: _firstName!,
              lastName: _lastName,
              email: _email!,
              uid: uid!,
              role: role);
        }
      } catch (e) {
        setState(() {
          _error = e.toString();
        });
        print(e);
      }
      setState(() {
        _loader = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Container(
          height: widget.authFormType == AuthFormType.signup ? 500 : 300,
          width: 400,
          child: Card(
            elevation: 2,
            child: _loader
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Column(
                    children: <Widget>[
                      showAlert(),
                      SizedBox(
                        height: height * .025,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            buildHeaderText(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: buildInputs() + buildButtons(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _error!,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
    return const SizedBox(height: 0);
  }

  AutoSizeText buildHeaderText() {
    String headerText;
    if (widget.authFormType == AuthFormType.signup) {
      headerText = "Create New Account";
    } else if (widget.authFormType == AuthFormType.reset) {
      headerText = "Reset Password";
    } else {
      headerText = "Sign In";
    }

    return AutoSizeText(
      headerText,
      maxLines: 1,
      textAlign: TextAlign.right,
      style: const TextStyle(fontSize: 25, color: Colors.black),
    );
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.black12,
      focusColor: Colors.black12,
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.white,
          width: 0.0,
        ),
      ),
      contentPadding: const EdgeInsets.only(left: 14, bottom: 10, top: 10),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    if (widget.authFormType == AuthFormType.reset) {
      textFields.add(
        TextFormField(
          validator: EmailValidator.validate,
          decoration: buildSignUpInputDecoration("Email"),
          onSaved: (value) {
            _email = value;
          },
        ),
      );

      textFields.add(const SizedBox(height: 20));
      return textFields;
    }

    if (widget.authFormType == AuthFormType.signup) {
      textFields.add(
        TextFormField(
          validator: NameValidator.validate,
          decoration: buildSignUpInputDecoration("First Name"),
          onSaved: (value) {
            _firstName = value;
          },
        ),
      );

      textFields.add(const SizedBox(height: 20));
      textFields.add(
        TextFormField(
          validator: NameValidator.validate,
          decoration: buildSignUpInputDecoration("Last Name"),
          onSaved: (value) {
            _lastName = value;
          },
        ),
      );

      textFields.add(const SizedBox(height: 20));
    }

    textFields.add(
      TextFormField(
        validator: EmailValidator.validate,
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (value) {
          _email = value;
        },
      ),
    );

    textFields.add(const SizedBox(height: 20));

    textFields.add(
      TextFormField(
        validator: PasswordValidator.validate,
        decoration: buildSignUpInputDecoration("Password"),
        obscureText: true,
        onSaved: (value) {
          _password = value;
        },
      ),
    );

    return textFields;
  }

  List<Widget> buildButtons() {
    String switchButtonText;
    String newFormState;
    String submitButtonText;

    if (widget.authFormType == AuthFormType.signin) {
      switchButtonText = "Create Account";
      newFormState = "signup";
      submitButtonText = "Sign In";
    } else {
      switchButtonText = "Have an Account? Sign In";
      newFormState = "signin";
      submitButtonText = "Sign Up";
    }

    return [
      const SizedBox(
        height: 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // MaterialButton(
          //   child: Text(
          //     switchButtonText,
          //   ),
          //   onPressed: () {
          //     switchFormState(newFormState);
          //   },
          // ),
          // const SizedBox(
          //   width: 20,
          // ),
          ElevatedButton(
            onPressed: submit,
            child: Text(
              submitButtonText,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      )
    ];
  }
}
