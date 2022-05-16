import 'package:flutter/material.dart';
import 'package:lms1/data/models/user_detail_response.dart';

class IssuedBookCard extends StatelessWidget {
  final IssuedBookModel book;
  const IssuedBookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //isThreeLine: true,
      style: ListTileStyle.drawer,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Text(
                "Name : ${book.name}",
                overflow: TextOverflow.fade,
              )),
              const SizedBox(width: 20),
              Text(
                "Fine : \u{20B9}${book.fine}",
                style: const TextStyle(color: Colors.red),
              ),
            ],
          ),
          Text("Author : ${book.author}"),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Text("Author: ${state.books[index].author}"),
          Row(
            children: [
              Expanded(
                child: Text("Issue Date: ${book.issueDate}"),
              ),
              Expanded(
                child: Text("Return Date: ${book.returnDate}"),
              ),
            ],
          ),
        ],
      ),
      leading: Icon(
        Icons.book,
        color: Colors.blue.withOpacity(0.5),
      ),
      //onTap: () {},
    );
  }
}
