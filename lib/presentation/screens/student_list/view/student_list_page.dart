import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/data/models/user_model.dart';
import 'package:lms1/presentation/components/user_list_search_delegate.dart';
import 'package:lms1/presentation/components/utils/helper.dart';
import 'package:lms1/presentation/components/widgets/widgets.dart';
import 'package:lms1/presentation/screens/student_list/student_list.dart';
import 'package:lms1/presentation/screens/user_detail/view/view.dart';

class StudentListPage extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const StudentListPage());

  const StudentListPage({Key? key}) : super(key: key);

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  late StudentListBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<StudentListBloc>(context);
  }

  @override
  void didChangeDependencies() {
    _bloc.add(FetchStudentList());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student'),
        centerTitle: true,
        actions: [
          BlocBuilder<StudentListBloc, StudentListState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  if (state is StudentListLoaded) {
                    showSearch(
                      context: context,
                      delegate: UserListSearchDelegate(
                        users: state.students,
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
      ),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext buildContext) {
    return BlocConsumer<StudentListBloc, StudentListState>(
      listener: (context, state) {},
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            _bloc.add(FetchStudentList());
          },
          child: showListDataList(state),
        );
      },
    );
  }

  showListDataList(StudentListState state) {
    if (state is StudentListLoading) {
      return const Center(child: LoadingWidget());
    } else if (state is StudentListLoaded) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: _showListView(state.students),
      );
    } else if (state is EmptyStudents) {
      return const Center(
        child: Text('No Students Available'),
      );
    } else if (state is StudentListFailed) {
      return SizedBox(
        height: double.infinity,
        child: Center(
          child: Text(state.message),
        ),
      );
    } else {
      return Container();
    }
  }

  _showListView(List<UserModel> users) => ListView.separated(
        itemCount: users.length,
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
                _bloc.add(FetchStudentList());
              });
            },
          );
        },
      );
}
