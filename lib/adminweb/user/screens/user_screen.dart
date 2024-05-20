import 'package:flavorsph/adminweb/user/provider/user_stream_provider.dart';
import 'package:flavorsph/adminweb/user/screens/user_table.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class UserScreen extends ConsumerStatefulWidget {
  const UserScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserScreenState();
}

class _UserScreenState extends ConsumerState<UserScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = ref.watch(usersProvider);

    return userProvider.when(
        data: (value) => UserTable(
              title: 'Users',
              headers: const ['First Name', 'Last Name', 'Email'],
              data: value,
            ),
        error: (error, stackTrace) => Text('Error: $error'),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}
