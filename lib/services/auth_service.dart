import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavorsph/adminweb/user/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AuthService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<UserModel> getUserById(String userId) async {
    final docRef = users.doc(userId);
    final snapshot = await docRef.get();
    return UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
  }
}

final authServiceProvider = Provider((ref) => AuthService());
