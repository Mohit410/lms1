import 'package:flutter/material.dart';
import 'package:lms1/data/models/user_detail_response.dart';

class FineHistoryCard extends StatelessWidget {
  final FineHistoryModel fine;
  const FineHistoryCard({Key? key, required this.fine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      //isThreeLine: true,
      style: ListTileStyle.drawer,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              "Book Id : ${fine.bookId}",
              overflow: TextOverflow.clip,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            "\u{20B9}${fine.fine}",
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
      subtitle: Wrap(
        children: [
          Text('Issue Date : ${fine.issueDate}'),
          Text('Actual Return Date : ${fine.actualReturnDate}'),
          Text('User Return Date : ${fine.userReturnDate}'),
        ],
      ),
      leading: Icon(
        Icons.currency_rupee,
        color: Colors.orange.withOpacity(0.5),
      ),
      //onTap: () {},
    );
  }
}
