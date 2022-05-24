import 'package:flutter/material.dart';
import 'package:lms1/data/models/models.dart';

class BookListTable extends DataTableSource {
  final List<BookModel> books;

  BookListTable(this.books);
  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(books[index].bookId)),
      DataCell(Text(books[index].title)),
      DataCell(Text(books[index].name)),
      DataCell(Text(books[index].publisher)),
      DataCell(Text(books[index].author)),
      DataCell(Text(books[index].category)),
      DataCell(Text(books[index].copies.toString())),
      DataCell(Text(books[index].availableCopies.toString())),
      DataCell(Text(books[index].price.toString())),
      DataCell(Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.details),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
        ],
      )),
    ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => books.length;

  @override
  int get selectedRowCount => 0;
}
