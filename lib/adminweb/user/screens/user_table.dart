import 'package:flavorsph/adminweb/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserTable extends ConsumerStatefulWidget {
  final String title;

  final List<String> headers;
  final List<UserModel> data;

  const UserTable(
      {super.key,
      required this.title,
      required this.headers,
      required this.data});

  @override
  ConsumerState<UserTable> createState() => _UserTableState();
}

class _UserTableState extends ConsumerState<UserTable> {
  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      onPageChanged: (value) {},
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.title),
        ],
      ),
      columns: widget.headers
          .map((value) => DataColumn(
                  label: Text(
                value,
                style: const TextStyle(fontWeight: FontWeight.bold),
              )))
          .toList(),
      source: MyDataTableSource(
        context: context,
        data: widget.data,
      ),
      rowsPerPage: 10, // Adjust the number of rows per page
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<UserModel> data;
  final BuildContext context;
  MyDataTableSource({required this.data, required this.context});

  @override
  DataRow getRow(int index) {
    final UserModel row = data[index];

    return DataRow(cells: [
      DataCell(Text(row.firstName ?? "")),
      DataCell(Text(row.lastName ?? "")),
      DataCell(Text(row.email ?? "")),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
