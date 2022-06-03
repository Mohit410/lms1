import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/presentation/components/user_list_search_delegate.dart';
import 'package:lms1/presentation/components/utils/helper.dart';
import 'package:lms1/presentation/components/widgets/widgets.dart';
import 'package:lms1/presentation/screens/admin_list/admin_list.dart';
import 'package:lms1/presentation/screens/user_detail/view/view.dart';

class AdminListPage extends StatefulWidget {
  const AdminListPage({Key? key}) : super(key: key);

  @override
  State<AdminListPage> createState() => _AdminListPageState();
}

class _AdminListPageState extends State<AdminListPage> {
  late AdminListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<AdminListBloc>(context);
  }

  @override
  void didChangeDependencies() {
    _bloc.add(FetchAdminList());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Admins',
            style: GoogleFonts.pacifico(),
          ),
        ),
        actions: [
          BlocBuilder<AdminListBloc, AdminListState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  if (state is AdminsLoaded) {
                    showSearch(
                      context: context,
                      delegate: UserListSearchDelegate(
                        users: state.admins,
                        showUsersList: (searchResult) =>
                            _showListView(searchResult),
                      ),
                    );
                  } else {
                    showSnackbar("No Users Available", context);
                  }
                },
                icon: const Icon(Icons.search),
              );
            },
          ),
        ],
        automaticallyImplyLeading: false,
        elevation: 1,
        foregroundColor: AppBarColors.foregroundColor.color,
        backgroundColor: AppBarColors.backgroundColor.color,
      ),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext buildContext) {
    return BlocConsumer<AdminListBloc, AdminListState>(
      listener: (context, state) {},
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            _bloc.add(FetchAdminList());
          },
          child: showListDataList(state),
        );
      },
    );
  }

  showListDataList(AdminListState state) {
    if (state is Loading) {
      return const Center(child: LoadingWidget());
    } else if (state is AdminsLoaded) {
      return _showListView(state.admins);
    } else if (state is EmptyAdmins) {
      return const Center(
        child: Text('No Admins Available'),
      );
    } else if (state is Failed) {
      return Center(
        child: Text(state.message),
      );
    } else {
      return Container();
    }
  }

  _showListView(List<UserModel> users) => ListView.separated(
        itemCount: users.length,
        cacheExtent: 1000,
        physics: const AlwaysScrollableScrollPhysics(),
        separatorBuilder: (context, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Name : ${users[index].name}"),
            subtitle: Text("Email: ${users[index].email}"),
            leading: const Icon(Icons.person),
            onTap: () {
              Navigator.of(context)
                  .push(UserDetailPage.route(
                      users[index].email, users[index].role))
                  .then((value) {
                _bloc.add(FetchAdminList());
              });
            },
          );
        },
      );
}
