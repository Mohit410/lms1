import 'package:flutter/material.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/data/models/user_detail_response.dart';
import 'package:lms1/presentation/components/utils/helper.dart';

class UnavailableBooksTable extends DataTableSource {
  final List<UnavailableBook> bookList;

  UnavailableBooksTable(this.bookList);

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return DataRow(cells: [
        DataCell(Text(bookList[index].id)),
        DataCell(Text(bookList[index].name)),
      ]);
    }
    return null;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => bookList.length;

  @override
  int get selectedRowCount => 0;
}

class IssuedBooksTable extends DataTableSource {
  final List<IssuedBookModel> books;

  IssuedBooksTable(this.books);

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return DataRow(cells: [
        DataCell(Text(books[index].name)),
        DataCell(Text(books[index].author)),
        DataCell(Text(books[index].publisher)),
        DataCell(Text(books[index].category)),
        DataCell(Text(books[index].issueDate)),
        DataCell(Text(books[index].returnDate)),
        DataCell(Text(books[index].fine.toString())),
      ]);
    }
    return null;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => books.length;

  @override
  int get selectedRowCount => 0;
}

class TransactionsTable extends DataTableSource {
  final List<TransactionModel> transactions;

  TransactionsTable(this.transactions);

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return DataRow(cells: [
        DataCell(Text(transactions[index].amount.toString())),
        DataCell(Text(transactions[index].transactionDate)),
        DataCell(Text(transactions[index].purpose)),
      ]);
    }
    return null;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => transactions.length;

  @override
  int get selectedRowCount => 0;
}

class FineHistoryTable extends DataTableSource {
  final List<FineHistoryModel> fineHistory;

  FineHistoryTable(this.fineHistory);

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return DataRow(cells: [
        DataCell(Text(fineHistory[index].bookId)),
        DataCell(Text(fineHistory[index].actualReturnDate)),
        DataCell(Text(fineHistory[index].userReturnDate)),
        DataCell(Text(fineHistory[index].fine.toString())),
      ]);
    }
    return null;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => fineHistory.length;

  @override
  int get selectedRowCount => 0;
}

class OverdueFineBooksTable extends DataTableSource {
  final List<StudentHeavyFineModel> fineList;

  OverdueFineBooksTable(this.fineList);

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
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
    return null;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => fineList.length;

  @override
  int get selectedRowCount => 0;
}
