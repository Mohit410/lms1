import 'package:flutter/material.dart';
import 'package:lms1/data/models/models.dart';

class UserListSearchDelegate extends SearchDelegate {
  final List<UserModel> users;
  final Widget Function(List<UserModel>) showUsersList;

  UserListSearchDelegate({required this.users, required this.showUsersList});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          }
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final _query = query.toLowerCase();
    final searchResult = users
        .where((user) =>
            user.name.toLowerCase().contains(_query) ||
            user.email.toLowerCase().contains(_query) ||
            user.phone.toLowerCase().contains(_query) ||
            user.address.toLowerCase().contains(_query) ||
            user.city.toLowerCase().contains(_query) ||
            user.state.toLowerCase().contains(_query) ||
            user.pincode.toLowerCase().contains(_query))
        .toList();

    if (searchResult.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("No Users Found"),
          ],
        ),
      );
    }

    return showUsersList(searchResult);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return showUsersList(users);
  }
}
