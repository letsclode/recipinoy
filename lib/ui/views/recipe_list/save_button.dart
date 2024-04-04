import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SavedButton extends ConsumerStatefulWidget {
  final bool isSave;
  final String id;
  final Function() updateData;
  const SavedButton(
      {super.key,
      required this.id,
      required this.isSave,
      required this.updateData});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SavedButtonState();
}

class _SavedButtonState extends ConsumerState<SavedButton> {
  late bool isSave;
  late String id;
  @override
  void initState() {
    // TODO: implement initState

    setState(() {
      isSave = widget.isSave;
      id = widget.id;

      print(id);
    });
    super.initState();
  }

  Future<void> updteSave() async {
    print("UPDATE IN VIEWMODEL");
    try {
      await FirebaseFirestore.instance
          .collection('recipes')
          .doc(id)
          .update({'isSave': !isSave}).then((value) => {
                setState(() {
                  isSave = !isSave;
                  widget.updateData();
                })
              });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (isSave) {
              return Colors.orange;
            } else {
              return Colors.grey;
            }
          }),
        ),
        onPressed: updteSave,
        child: Text(
          "Save",
          style: TextStyle(color: Colors.white),
        ));
  }
}
