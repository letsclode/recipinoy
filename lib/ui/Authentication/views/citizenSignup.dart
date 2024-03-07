// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flavorsph/app/app.locator.dart';
// import 'package:flavorsph/app/app.router.dart';
// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:stacked_services/stacked_services.dart';

// import '../../../adminweb/color.dart';
// import '../../../adminweb/controllers/auth_controller.dart';
// import '../../../adminweb/controllers/user_controller.dart';
// import '../../../constant/size.dart';

// class CitizenSignup extends ConsumerStatefulWidget {
//   final bool isSigningUp;
//   const CitizenSignup({super.key, this.isSigningUp = false});

//   @override
//   ConsumerState<CitizenSignup> createState() => _CitizenSignupState();
// }

// class _CitizenSignupState extends ConsumerState<CitizenSignup> {
//   final _navigationService = locator<NavigationService>();
//   final formKey = GlobalKey<FormState>();
//   final GlobalKey key = GlobalKey();

//   bool isLoading = false;

//   String? _number;
//   String? _email;
//   String? _fristName;
//   String? _lastName;
//   // String? _birthday;
//   // String? _gender;
//   String? _password;
//   String? _confirmPassword;
//   String? _error;

//   bool _obscure = true;

//   bool validate() {
//     final form = formKey.currentState;
//     form!.save();
//     if (form.validate()) {
//       form.save();
//       return true;
//     } else {
//       return false;
//     }
//   }

//   Future login() async {
//     setState(() {
//       isLoading = true;
//     });
//     final authProvider = ref.watch(authControllerProvider.notifier);

//     try {
//       await authProvider
//           .signInWithEmailAndPassword(email: _email!, password: _password!)
//           .then((value) {
//         setState(() {
//           isLoading = false;
//         });
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         _error = e.toString();
//       });
//     }
//   }

//   Future registerUser() async {
//     final authProvider = ref.watch(authControllerProvider.notifier);
//     final userProvider = ref.read(userControllerProvider.notifier);

//     setState(() {
//       isLoading = true;
//     });

//     try {
//       await authProvider
//           .createUserWithEmailAndPassword(email: _email!, password: _password!)
//           .then((value) async {
//         String role = "client";
//         await userProvider.storeNewUser(
//             firstName: _fristName,
//             lastName: _lastName,
//             email: _email,
//             uid: value!,
//             role: role);
//         print('user created');
//         _navigationService.replaceWithHomeView();
//       });
//     } catch (e) {
//       setState(() {
//         isLoading = false;
//         _error = e.toString();
//       });
//     }
//   }

//   void submit() async {
//     if (validate()) {
//       try {
//         if (widget.isSigningUp) {
//           await registerUser();
//         } else {
//           await login();
//         }
//       } catch (e) {
//         setState(() {
//           isLoading = false;
//           _error = e.toString();
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;

//     return SingleChildScrollView(
//       child: SizedBox(
//         height: height,
//         width: width,
//         child: SafeArea(
//           child: isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : SingleChildScrollView(
//                   child: Column(
//                     children: <Widget>[
//                       showAlert(),
//                       SizedBox(
//                         height: height * .025,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Form(
//                           key: formKey,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: buildInputs() + buildButtons(),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//         ),
//       ),
//     );
//   }

//   Widget showAlert() {
//     if (_error != null) {
//       return Container(
//         color: secondaryColor,
//         width: double.infinity,
//         padding: const EdgeInsets.all(8),
//         child: Row(
//           children: <Widget>[
//             const Padding(
//               padding: EdgeInsets.only(right: 8.0),
//               child: Icon(Icons.error_outline),
//             ),
//             Expanded(
//               child: AutoSizeText(
//                 _error!,
//                 maxLines: 3,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: IconButton(
//                 icon: const Icon(Icons.close),
//                 onPressed: () {
//                   setState(() {
//                     _error = null;
//                   });
//                 },
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//     return const SizedBox(height: 0);
//   }

//   InputDecoration buildSignUpInputDecoration(String hint,
//       {bool isPassword = false}) {
//     return InputDecoration(
//       suffixIcon: isPassword
//           ? IconButton(
//               onPressed: () {
//                 setState(() {
//                   _obscure = !_obscure;
//                 });
//               },
//               icon: const Icon(Icons.visibility_off))
//           : null,
//       hintText: hint,
//       filled: true,
//       fillColor: Colors.white,
//       focusColor: Colors.white,
//       enabledBorder: const OutlineInputBorder(
//         borderSide: BorderSide(
//           color: Colors.black12,
//           width: 0.0,
//         ),
//       ),
//       contentPadding: const EdgeInsets.only(left: 14, bottom: 10, top: 10),
//     );
//   }

//   List<Widget> buildInputs() {
//     List<Widget> textFields = [];

//     textFields.add(const Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(vertical: 8),
//           child: AutoSizeText(
//             "Welcome to FlavorsPH",
//             maxLines: 2,
//             textAlign: TextAlign.center,
//             style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     ));

//     textFields.add(
//       TextFormField(
//         keyboardType: TextInputType.emailAddress,
//         validator: EmailValidator.validate,
//         decoration: buildSignUpInputDecoration("Email"),
//         onSaved: (value) {
//           _email = value;
//         },
//       ),
//     );
//     textFields.add(const SizedBox(
//       height: KXFontSize.small,
//     ));

//     textFields.add(
//       TextFormField(
//         keyboardType: TextInputType.visiblePassword,
//         validator: PasswordValidator.validate,
//         decoration: buildSignUpInputDecoration("Password", isPassword: true),
//         obscureText: _obscure,
//         onSaved: (value) {
//           _password = value;
//         },
//       ),
//     );
//     textFields.add(const SizedBox(
//       height: KXFontSize.small,
//     ));

//     if (widget.isSigningUp) {
//       textFields.add(
//         TextFormField(
//           keyboardType: TextInputType.visiblePassword,
//           validator: (String? value) {
//             return ConfirmPasswordValidator.validate(value, _password);
//           },
//           decoration:
//               buildSignUpInputDecoration("Confirm Password", isPassword: true),
//           obscureText: _obscure,
//           onSaved: (value) {
//             _confirmPassword = value;
//           },
//         ),
//       );
//       textFields.add(const SizedBox(
//         height: KXFontSize.small,
//       ));
//       textFields.add(
//         TextFormField(
//           keyboardType: TextInputType.text,
//           validator: NameValidator.validate,
//           decoration: buildSignUpInputDecoration("First Name"),
//           onSaved: (value) {
//             _fristName = value;
//           },
//         ),
//       );

//       textFields.add(const SizedBox(
//         height: KXFontSize.small,
//       ));
//       textFields.add(
//         TextFormField(
//           keyboardType: TextInputType.text,
//           validator: NameValidator.validate,
//           decoration: buildSignUpInputDecoration("Last Name"),
//           onSaved: (value) {
//             _lastName = value;
//           },
//         ),
//       );

//       textFields.add(const SizedBox(
//         height: KXFontSize.small,
//       ));
//     }

//     return textFields;
//   }

//   List<Widget> buildButtons() {
//     String switchButtonText;
//     String submitButtonText;

//     if (widget.isSigningUp) {
//       switchButtonText = "Already have account? Login";
//       submitButtonText = "Register";
//     } else {
//       switchButtonText = "No account yet? Register";
//       submitButtonText = "Login";
//     }

//     return [
//       if (widget.isSigningUp)
//         // TextButton(
//         //     onPressed: () {
//         //       setState(() {
//         //         widget.isSigningUp = !widget.isSigningUp;
//         //       });
//         //     },
//         //     child: Text(switchButtonText)),
//         const SizedBox(
//           height: KXFontSize.medium,
//         ),
//       SizedBox(
//         width: double.infinity,
//         child: MaterialButton(
//           key: key,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//           ),
//           color: secondaryColor,
//           onPressed: submit,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               submitButtonText,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ),
//       ),
//     ];
//   }
// }
