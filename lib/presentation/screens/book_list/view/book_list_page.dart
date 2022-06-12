import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/presentation/components/utils/helper.dart';
import 'package:lms1/presentation/components/widgets/widgets.dart';
import 'package:lms1/presentation/screens/add_new_book/add_new_book.dart';
import 'package:lms1/presentation/screens/book_details/book_details.dart';
import 'package:lms1/presentation/screens/book_list/book_list.dart';
import 'package:lms1/presentation/screens/book_list/view/components/book_search_delegate.dart';
import 'package:lms1/presentation/screens/book_list/view/components/issue_confirm_dialog.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  late BookListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<BookListBloc>(context);
  }

  @override
  void didChangeDependencies() {
    _bloc.add(FetchBooks());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookListBloc, BookListState>(
      listener: (context, state) {
        if (state is IssueBookSuccess) {
          showSnackbar(state.message, context);
          _refreshList();
        }
        if (state is IssueBookFailed) {
          showSnackbar(state.message, context);
          _refreshList();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Books'),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  state is BookListLoaded
                      ? showSearch(
                          context: context,
                          delegate: BookSearchDelegate(
                            books: state.books,
                            showListView: (books) => _showListView(books),
                          ),
                        )
                      : showSnackbar("No books available to search", context);
                },
                icon: const Icon(
                  Icons.search,
                ),
              ),
            ],
            automaticallyImplyLeading: false,
          ),
          body: (state is BookListLoading)
              ? const Center(child: LoadingWidget())
              : RefreshIndicator(
                  onRefresh: () async {
                    _refreshList();
                  },
                  child: _showListDataList(state),
                ),
        );
      },
    );
  }

  _refreshList() => _bloc.add(FetchBooks());

  _showListDataList(BookListState state) {
    if (state is BookListLoaded) {
      return _showListView(state.books);
    } else {
      return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            state is BookListFailed
                ? Text(state.message)
                : state is EmptyBookList
                    ? const Text('No Books Available')
                    : Container(),
            TextButton(
              onPressed: () {
                _bloc.add(FetchBooks());
              },
              child: const Text("Retry"),
            )
          ],
        ),
      );
    }
  }

  Widget _showListView(List<BookModel> books) => ListView.separated(
        cacheExtent: 10,
        padding: const EdgeInsets.all(8),
        itemCount: books.length,
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (context, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: (UserPreferences.userRole == Role.admin.name)
                  ? [_showDetailsSlidable(books[index].bookId)]
                  : (UserPreferences.userRole == Role.librarian.name)
                      ? [
                          _showDetailsSlidable(books[index].bookId),
                          _editSlidable(books[index])
                        ]
                      : [_issueSlidable(books[index].bookId)],
            ),
            child: _getListTile(books[index]),
          );
        },
      );

  _showDetailsSlidable(String bookId) => SlidableAction(
        onPressed: (context) async {
          await Navigator.of(context).push(BookDetailsPage.route(bookId));
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        icon: Icons.view_agenda,
        label: 'Details',
      );

  _editSlidable(BookModel book) => SlidableAction(
        onPressed: (context) async {
          await Navigator.push(
                  context, AddNewBookPage.route(book, PageMode.edit))
              .then(
            (value) => _bloc.add(FetchBooks()),
          );
        },
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        icon: Icons.edit,
        label: 'Edit',
      );

  _issueSlidable(String bookId) => SlidableAction(
        onPressed: (context) async {
          showDialog(
            context: context,
            builder: (context) => IssueConfirmDialog(bookId: bookId),
          );
        },
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        icon: Icons.book,
        label: 'Issue Book',
      );

  _getListTile(BookModel book) => ListTile(
        isThreeLine: true,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Title : ${book.title}"),
            Text("Name : ${book.name}"),
          ],
        ),
        subtitle:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("Author: ${book.author}"),
          Row(
            children: [
              Expanded(
                child: Text("Available Copies: ${book.availableCopies}"),
              ),
              Expanded(
                child: Text("Total Copies: ${book.copies}"),
              ),
            ],
          ),
        ]),
      );
}
