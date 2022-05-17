import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
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
        title: Center(
          child: Text(
            'Student',
            style: GoogleFonts.pacifico(),
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
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
    if (state is Loading) {
      return const Center(child: LoadingWidget());
    } else if (state is StudentsLoaded) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          cacheExtent: 1000,
          itemCount: state.students.length,
          physics: const AlwaysScrollableScrollPhysics(),
          separatorBuilder: (context, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("Name : ${state.students[index].name}"),
              subtitle: Text("Email: ${state.students[index].email}"),
              leading: const Icon(Icons.person),
              onTap: () {
                Navigator.of(context)
                    .push(
                  UserDetailPage.route(
                    state.students[index].email,
                    state.students[index].role,
                  ),
                )
                    .then((value) {
                  _bloc.add(FetchStudentList());
                });
              },
            );
          },
        ),
      );
    } else if (state is EmptyStudents) {
      return const Center(
        child: Text('No Students Available'),
      );
    } else if (state is Failed) {
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
}
