import 'package:flutter/material.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/presentation/components/utils/helper.dart';

class UnavailableBooksTable extends DataTableSource {
  final List<UnavailableBook> bookList;

  UnavailableBooksTable(this.bookList);

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(bookList[index].id)),
      DataCell(Text(bookList[index].name)),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => bookList.length;

  @override
  int get selectedRowCount => 0;
}

class OverdueFineBooksTable extends DataTableSource {
  final List<StudentHeavyFineModel> fineList;

  OverdueFineBooksTable(this.fineList);

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(Text(fineList[index].email)),
        DataCell(Text(
          "$rupeeSymbol${fineList[index].fine}",
          style: const TextStyle(color: Colors.red),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => fineList.length;

  @override
  int get selectedRowCount => 0;
}
