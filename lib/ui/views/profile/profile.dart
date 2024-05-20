import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavorsph/adminweb/controllers/auth_controller.dart';
import 'package:flavorsph/adminweb/controllers/user_controller.dart';
import 'package:flavorsph/constant/color.dart';
import 'package:flavorsph/ui/common/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../widgets/title_button.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();

  FocusNode nameFocus = FocusNode();

  @override
  void initState() {
    final user = ref.read(authControllerProvider);

    ref
        .read(userControllerProvider.notifier)
        .getUserById(id: user!.uid)
        .then((value) {
      setState(() {
        name.text = value.firstName ?? '';
        email.text = value.email ?? '';
        number.text = value.number ?? '';
      });
    });

    super.initState();
  }

  bool isLoading = false;
  void updateDisplayName() async {
    final user = ref.read(authControllerProvider);
    setState(() {
      isLoading = true;
    });
    if (name.text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({"firstName": name.text}).whenComplete(() {
        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(authControllerProvider);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              TitleButton(
                title: 'Profile',
              )
            ],
          ),
          verticalSpaceLarge,
          user!.photoURL != null
              ? Image.network(user.photoURL!)
              : CircleAvatar(
                  radius: 50,
                  child: Text(
                    user.email![0],
                    style: TextStyle(fontSize: 50),
                  ),
                ),
          verticalSpaceLarge,
          TextField(
            focusNode: nameFocus,
            controller: name,
            onChanged: (value) {
              setState(() {});
            },
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                suffixIcon: name.text.isNotEmpty && nameFocus.hasFocus
                    ? isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : TextButton(
                            onPressed: () {
                              updateDisplayName();
                            },
                            child: Text("Save"))
                    : IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                hintText: "Name"),
          ),
          // verticalSpaceSmall,
          // TextField(
          //   readOnly: true,
          //   decoration: InputDecoration(
          //       prefixIcon: Icon(Icons.numbers),
          //       // suffixIcon: number.text != user!.phoneNumber
          //       //     ? TextButton(onPressed: () {}, child: Text("Save"))
          //       //     : IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          //       border: OutlineInputBorder(
          //           borderRadius: BorderRadius.all(Radius.circular(50))),
          //       hintText: "Number"),
          // ),
          verticalSpaceSmall,
          TextField(
            readOnly: true,
            controller: email,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                hintText: "Email"),
          ),
          verticalSpaceSmall,
          Container(
            width: double.infinity,
            child: Consumer(builder: (context, ref, child) {
              final userProvider = ref.read(authControllerProvider.notifier);
              return MaterialButton(
                color: color1,
                onPressed: () {
                  userProvider.signOut();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout),
                    horizontalSpaceSmall,
                    Text('Sign out')
                  ],
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
