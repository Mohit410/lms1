import 'package:flutter/material.dart';
import 'package:lms1/data/models/user_detail_response.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionCard({Key? key, required this.transaction})
      : super(key: key);

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
              transaction.purpose,
              overflow: TextOverflow.clip,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            "\u{20B9}${transaction.amount}",
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ),
      subtitle: Text('Date : ${transaction.transactionDate}'),
      leading: Icon(
        Icons.currency_rupee,
        color: Colors.orange.withOpacity(0.5),
      ),
      //onTap: () {},
    );
  }
}
