import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavorsph/adminweb/user/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'user_stream_provider.g.dart';

@riverpod
Stream<List<UserModel>> users(UsersRef ref) async* {
  try {
    final stream = FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => UserModel.fromJson(doc.data()))
          .toList();
    });

    await for (final event in stream) {
      yield event;
    }
  } catch (e) {
    print(e);
  }
}
