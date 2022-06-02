import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/presentation/components/utils/helper.dart';
import 'package:lms1/presentation/screens/return_book/return_book.dart';

class ReturnBookDialog extends StatefulWidget {
  final ReturnBookModel issuedBook;
  const ReturnBookDialog({Key? key, required this.issuedBook})
      : super(key: key);

  @override
  State<ReturnBookDialog> createState() => _ReturnBookDialogState();
}

class _ReturnBookDialogState extends State<ReturnBookDialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Return Book',
          style: GoogleFonts.pacifico(),
        ),
        elevation: 1,
        foregroundColor: AppBarColors.foregroundColor.color,
        backgroundColor: AppBarColors.backgroundColor.color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              headingText("Book Id"),
              const SizedBox(height: 8),
              fieldText(widget.issuedBook.bookId),
              const SizedBox(height: 20),
              headingText("Issued By"),
              const SizedBox(height: 8),
              fieldText(widget.issuedBook.issuedBy),
              const SizedBox(height: 20),
              headingText("Issue Date"),
              const SizedBox(height: 8),
              fieldText(widget.issuedBook.issueDate),
              const SizedBox(height: 20),
              headingText("Return Date"),
              const SizedBox(height: 8),
              fieldText(widget.issuedBook.returnDate),
              const SizedBox(height: 20),
              headingText("Fine"),
              const SizedBox(height: 8),
              fieldText("$rupeeSymbol${widget.issuedBook.fine}"),
              const Spacer(),
              _returnButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  _popDialog() {
    Navigator.pop(context);
  }

  _returnButton() => ElevatedButton(
        child: const Text(
          "Return Book",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
          onPrimary: Colors.white,
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => _dialog(),
          );
        },
      );

  _dialog() => AlertDialog(
        title: const Text('Confirm'),
        content: const Text('Want to return this book?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL', style: TextStyle(color: Colors.red)),
          ),
          BlocListener<ReturnBookBloc, ReturnBookState>(
            listener: (context, state) {
              if (state is ReturnBookSuccess) {
                Navigator.pop(context);
                _popDialog();
              }
              if (state is ReturnBookFailed) {
                Navigator.pop(context);
              }
            },
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<ReturnBookBloc>(context).add(
                  ReturnBookClicked(
                    widget.issuedBook.bookId,
                    widget.issuedBook.issuedBy,
                    widget.issuedBook.issueDate,
                    widget.issuedBook.returnDate,
                    widget.issuedBook.fine,
                  ),
                );
                _popDialog();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Color(0xFF6200EE)),
              ),
            ),
          ),
        ],
      );
}
