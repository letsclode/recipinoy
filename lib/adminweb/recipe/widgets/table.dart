import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavorsph/adminweb/color.dart';
import 'package:flavorsph/adminweb/recipe/recipe/admin_recipe_details.dart';
import 'package:flavorsph/adminweb/recipe/widgets/recipe_form.dart';
import 'package:flavorsph/ui/models/recipe/recipe_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecipeTable extends ConsumerStatefulWidget {
  final String title;

  final List<String> headers;
  final List<RecipeModel> data;
  final bool isMobile;

  const RecipeTable(
      {super.key,
      required this.title,
      required this.headers,
      required this.data,
      required this.isMobile});

  @override
  ConsumerState<RecipeTable> createState() => _RecipeTableState();
}

class _RecipeTableState extends ConsumerState<RecipeTable> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        actions: [
          Container(
            width: 150,
            height: 40,
            child: MaterialButton(
              color: kPrimaryColor,
              textColor: Colors.white,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: Center(child: Text("Adding Recipe")),
                        content: Container(width: 400, child: MyCustomForm()),
                      );
                    });
              },
              child: Text('Add recipe'),
            ),
          )
        ],
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
            context: context, data: widget.data, isMobile: widget.isMobile),
        rowsPerPage: 10, // Adjust the number of rows per page
      ),
    );
  }
}

class MyDataTableSource extends DataTableSource {
  final List<RecipeModel> data;
  final BuildContext context;
  final bool isMobile;
  MyDataTableSource(
      {required this.data, required this.context, required this.isMobile});

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
                      width: 400, child: AdminRecipeDetails(data: row)),
                );
              });
        },
        cells: [
          DataCell(Text(row.title.toString())),
          if (!isMobile)
            DataCell(Text(
              row.time.toString(),
              overflow: TextOverflow.ellipsis,
            )),
          DataCell(Row(
            children: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return AlertDialog(
                            title: Center(child: Text("Adding Recipe")),
                            content: Container(
                                width: 400,
                                child: MyCustomForm(
                                  editableRecipe: row,
                                )),
                          );
                        });
                  },
                  icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Delete confirmation!"),
                            content: SizedBox(
                              height: MediaQuery.of(context).size.height / 15,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      MaterialButton(
                                        color: secondaryColor,
                                        onPressed: () async {
                                          await FirebaseFirestore.instance
                                              .collection('recipes')
                                              .doc(row.id)
                                              .delete();
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          "delete",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      OutlinedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel"))
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  icon: Icon(Icons.delete))
            ],
          )),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
