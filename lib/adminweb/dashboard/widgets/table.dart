import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:flavorsph/ui/widgets/recipe_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecipeTable extends ConsumerStatefulWidget {
  final String title;

  final List<String> headers;
  final List<RecipeModel> data;

  const RecipeTable(
      {super.key,
      required this.title,
      required this.headers,
      required this.data});

  @override
  ConsumerState<RecipeTable> createState() => _RecipeTableState();
}

class _RecipeTableState extends ConsumerState<RecipeTable> {
  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      showCheckboxColumn: false,
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
  final List<RecipeModel> data;
  final BuildContext context;
  MyDataTableSource({required this.data, required this.context});

  @override
  DataRow getRow(int index) {
    final RecipeModel row = data[index];

    return DataRow(
        onSelectChanged: (value) {
          print(row);
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("Details"),
                  content: Container(
                      width: 400,
                      child: RecipeDetailPage(
                          data: row, availableIngredients: [])),
                );
              });
        },
        cells: [
          DataCell(Text(row.title.toString())),
          DataCell(Text(row.time.toString())),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
