import 'package:flutter/material.dart';

import 'package:lms1/data/models/models.dart';

class BookSearchDelegate extends SearchDelegate {
  List<BookModel> books;
  Widget Function(List<BookModel> books) showListView;
  BookSearchDelegate({
    required this.books,
    required this.showListView,
  });

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
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
    final searchResult = books
        .where(
          (book) => (book.bookId.toLowerCase().contains(_query) ||
              book.title.toLowerCase().contains(_query) ||
              book.name.toLowerCase().contains(_query) ||
              book.publisher.toLowerCase().contains(_query) ||
              book.author.toLowerCase().contains(_query) ||
              book.category.toLowerCase().contains(_query) ||
              book.price.toString().toLowerCase().contains(_query) ||
              book.addedBy.toLowerCase().contains(_query)),
        )
        .toList();

    if (searchResult.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text("No Books Found"),
          ],
        ),
      );
    }

    return showListView(searchResult);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return showListView(books);
  }
}
