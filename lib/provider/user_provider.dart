import 'package:flavorsph/adminweb/user/user_model.dart';
import 'package:flavorsph/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final userProvider = FutureProvider.family<UserModel, String>((ref, id) async {
  return ref.watch(authServiceProvider).getUserById(id);
});
