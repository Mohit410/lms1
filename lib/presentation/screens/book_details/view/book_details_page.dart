import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/presentation/components/widgets/widgets.dart';
import 'package:lms1/presentation/screens/book_details/book_details.dart';

class BookDetailsPage extends StatefulWidget {
  static Route route(String bookId) =>
      MaterialPageRoute(builder: (_) => BookDetailsPage(bookId: bookId));

  final String bookId;
  const BookDetailsPage({Key? key, required this.bookId}) : super(key: key);

  @override
  State<BookDetailsPage> createState() => _BookDetailsPageState();
}

class _BookDetailsPageState extends State<BookDetailsPage> {
  late BookDetailsBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<BookDetailsBloc>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _bloc.add(FetchBookDetails(widget.bookId));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Details',
        ),
      ),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext buildContext) {
    return BlocConsumer<BookDetailsBloc, BookDetailsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is BookDetailsLoading) {
          return const Center(child: LoadingWidget());
        }
        if (state is BookDetailsLoaded) {
          return Stack(
            children: [
              (state.issuedBooks.isEmpty)
                  ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No data available'),
                          TextButton(
                              onPressed: () {
                                _bloc.add(FetchBookDetails(widget.bookId));
                              },
                              child: const Text("Retry"))
                        ],
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        _bloc.add(FetchBookDetails(widget.bookId));
                      },
                      child: SingleChildScrollView(
                        clipBehavior: Clip.antiAlias,
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: refreshIndicatorChild(state),
                      ),
                    ),
            ],
          );
        } else if (state is BookDetailsFailed) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text(state.message)),
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text('No data'),
            ],
          );
        }
      },
    );
  }

  refreshIndicatorChild(state) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "Issued By : ${state.issuedBooks[index].issuedBy}",
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "Fine : \u{20B9}${state.issuedBooks[index].fine}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
                subtitle: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Text('Issue Date : ${state.issuedBooks[index].issueDate}'),
                    Text(
                        'Return Date : ${state.issuedBooks[index].returnDate}'),
                  ],
                ),
              ),
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemCount: state.issuedBooks.length,
            ),
            const SizedBox(height: 10),
            const Divider(height: 1),
          ],
        ),
      ),
    );
  }
}
