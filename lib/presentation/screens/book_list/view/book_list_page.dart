import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/presentation/components/widgets/widgets.dart';
import 'package:lms1/presentation/screens/add_new_book/add_new_book.dart';
import 'package:lms1/presentation/screens/book_details/book_details.dart';
import 'package:lms1/presentation/screens/book_list/book_list.dart';
import 'package:lms1/presentation/screens/book_list/view/components/book_list_table.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Books',
            style: GoogleFonts.pacifico(),
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
        foregroundColor: AppBarColors.foregroundColor.color,
        backgroundColor: AppBarColors.backgroundColor.color,
      ),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    return BlocConsumer<BookListBloc, BookListState>(
      listener: (context, state) {},
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            _bloc.add(FetchBooks());
          },
          child: showListDataList(state),
        );
      },
    );
  }

  showListDataList(BookListState state) {
    if (state is Loading) {
      return const Center(child: LoadingWidget());
    } else if (state is BooksLoaded) {
      return ListView.separated(
        cacheExtent: 10,
        padding: const EdgeInsets.all(16),
        itemCount: state.books.length,
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (context, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) async {
                    await Navigator.of(context)
                        .push(BookDetailsPage.route(state.books[index].bookId));
                    //.then((value) => _bloc.add(FetchBooks()));
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  icon: Icons.view_agenda,
                  label: 'Details',
                ),
                (UserPreferences.userRole == Role.librarian.name)
                    ? SlidableAction(
                        onPressed: (context) async {
                          await Navigator.push(
                                  context,
                                  AddNewBookPage.route(
                                      state.books[index], PageMode.edit))
                              .then((value) => _bloc.add(FetchBooks()));
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      )
                    : Container(),
              ],
            ),
            child: _getListTile(state.books[index]),
          );
        },
      );
    } else if (state is EmptyBookList) {
      return const Center(
        child: Text('No Books Available'),
      );
    } else if (state is Failed) {
      return Center(
        child: Text(state.message),
      );
    } else {
      return Container();
    }
  }

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

  _getBooksTable(List<BookModel> books) => PaginatedDataTable(
        columns: const [
          DataColumn(label: Text('Id')),
          DataColumn(label: Text('Title')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Publisher')),
          DataColumn(label: Text('Author')),
          DataColumn(label: Text('Category')),
          DataColumn(label: Text('Total Copies')),
          DataColumn(label: Text('Available Copies')),
          DataColumn(label: Text('Price (Rs.)')),
          DataColumn(label: Text('Action')),
        ],
        source: BookListTable(books),
        header: const Text('Books'),
        horizontalMargin: 10,
        columnSpacing: 16,
        rowsPerPage: 10,
        showCheckboxColumn: false,
      );
}
