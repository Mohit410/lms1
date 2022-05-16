import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/presentation/components/widgets/widgets.dart';
import 'package:lms1/presentation/screens/librarian_list/librarian_list.dart';
import 'package:lms1/presentation/screens/user_detail/view/view.dart';

class LibrarianListPage extends StatefulWidget {
  const LibrarianListPage({Key? key}) : super(key: key);

  @override
  State<LibrarianListPage> createState() => _LibrarianListPageState();
}

class _LibrarianListPageState extends State<LibrarianListPage> {
  late LibrarianListBloc _bloc;
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<LibrarianListBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc.add(FetchLibrarianList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Librarians',
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

  buildBody(BuildContext buildContext) {
    return BlocConsumer<LibrarianListBloc, LibrarianListState>(
      listener: (context, state) {},
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            _bloc.add(FetchLibrarianList());
          },
          child: showListDataList(state),
        );
      },
    );
  }

  showListDataList(LibrarianListState state) {
    if (state is Loading) {
      return const Center(child: LoadingWidget());
    } else if (state is LibrariansLoaded) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: state.librarians.length,
          cacheExtent: 1000,
          physics: const AlwaysScrollableScrollPhysics(),
          separatorBuilder: (context, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Name : ${state.librarians[index].name}"),
              subtitle: Text("Email: ${state.librarians[index].email}"),
              leading: const Icon(Icons.person),
              onTap: () {
                Navigator.of(context)
                    .push(UserDetailPage.route(
                  state.librarians[index].email,
                  state.librarians[index].role,
                ))
                    .then((value) {
                  _bloc.add(FetchLibrarianList());
                });
              },
            );
          },
        ),
      );
    } else if (state is EmptyLibrarians) {
      return const Center(
        child: Text('No Librarains Available'),
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
