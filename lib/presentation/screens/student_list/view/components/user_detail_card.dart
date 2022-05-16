import 'package:flutter/material.dart';

import 'package:lms1/data/models/models.dart';

class UserDetailCard extends StatelessWidget {
  final UserModel user;
  const UserDetailCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                text: 'Name',
                children: [
                  TextSpan(
                    text: user.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
