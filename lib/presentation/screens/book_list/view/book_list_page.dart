import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/presentation/components/widgets/widgets.dart';
import 'package:lms1/presentation/screens/book_details/book_details.dart';
import 'package:lms1/presentation/screens/book_list/book_list.dart';

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
          return ListTile(
            isThreeLine: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title : ${state.books[index].title}"),
                Text("Name : ${state.books[index].name}"),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Author: ${state.books[index].author}"),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          "Available Copies: ${state.books[index].availableCopies}"),
                    ),
                    Expanded(
                      child: Text("Total Copies: ${state.books[index].copies}"),
                    ),
                  ],
                ),
              ],
            ),
            //leading: const Icon(Icons.book),
            onTap: () => Navigator.of(context).push(
              BookDetailsPage.route(state.books[index].bookId),
            ),
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
}
