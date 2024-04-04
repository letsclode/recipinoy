import 'package:flavorsph/ui/widgets/full_screen_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/feedback/feedback_model.dart';

class FeedbackTable extends ConsumerStatefulWidget {
  final String title;

  final List<String> headers;
  final List<FeedbackModel> data;

  const FeedbackTable(
      {super.key,
      required this.title,
      required this.headers,
      required this.data});

  @override
  ConsumerState<FeedbackTable> createState() => _FeedbackTableState();
}

class _FeedbackTableState extends ConsumerState<FeedbackTable> {
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
  final List<FeedbackModel> data;
  final BuildContext context;
  MyDataTableSource({required this.data, required this.context});

  @override
  DataRow getRow(int index) {
    final FeedbackModel row = data[index];

    return DataRow(cells: [
      DataCell(Text(row.user)),
      DataCell(Text(row.text)),
      DataCell(TextButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FullScreenImage(
                    image:
                        Image.network(row.screenshot, fit: BoxFit.fitHeight))));
          },
          child: Text("View Image"))),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
