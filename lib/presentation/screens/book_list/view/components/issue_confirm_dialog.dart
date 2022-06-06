import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms1/presentation/screens/book_list/book_list.dart';

class IssueConfirmDialog extends StatelessWidget {
  final String bookId;
  const IssueConfirmDialog({Key? key, required this.bookId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Issue Book"),
      content: const Text('Are you sure you want to issue this book?'),
      actions: [
        TextButton(
          onPressed: () => _dismis(context),
          child: const Text('CANCEL', style: TextStyle(color: Colors.red)),
        ),
        ElevatedButton(
          onPressed: () => _issueBook(context),
          child: const Text("Issue Book", style: TextStyle(color: Colors.blue)),
        )
      ],
    );
  }

  void _dismis(BuildContext context) => Navigator.pop(context);

  void _issueBook(BuildContext context) {
    BlocProvider.of<BookListBloc>(context).add(IssueBook(bookId));
    Navigator.pop(context);
  }
}
