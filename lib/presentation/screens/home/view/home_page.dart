import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/presentation/components/utils/helper.dart';
import 'package:lms1/presentation/screens/admin_list/view/admin_list_page.dart';
import 'package:lms1/presentation/screens/book_list/view/view.dart';
import 'package:lms1/presentation/screens/dashboard/dashboard.dart';
import 'package:lms1/presentation/screens/home/home.dart';
import 'package:lms1/presentation/screens/librarian_list/view/librarian_list_page.dart';
import 'package:lms1/presentation/screens/register/register.dart';
import 'package:lms1/presentation/screens/student_list/student_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

const TextStyle textStyle = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
  fontStyle: FontStyle.italic,
);

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late NavigationBloc _bloc;
  final isDialOpen = ValueNotifier(false);

  int _currentIndex = 0;
  final ADMIN_PAGES = const [
    DashboardPage(),
    StudentListPage(),
    LibrarianListPage(),
    AdminListPage(),
    BookListPage(),
  ];

  final STUDENT_PAGES = [];

  final LIBRARIAN_PAGES = [];

  @override
  void initState() {
    _bloc = BlocProvider.of<NavigationBloc>(context);
    super.initState();
  }

  pickFile() async {
    final result = await FilePicker.platform.pickFiles(
        //allowedExtensions: ['xls', 'xlxs'],
        );

    if (result == null) return;

    final file = result.files.single;
    final supportedFiles = ['xls', 'xlsx'];
    if (supportedFiles.contains(file.extension)) {
      _bloc.add(UploadBulkUsers(result.files.single));
    } else {
      showSnackbar("Only '.xls' and '.xlsx' file supported", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isDialOpen.value) {
          isDialOpen.value = false;
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: null,
        floatingActionButton: getFAB(),
        bottomNavigationBar: NavigationBar(
          height: 60,
          animationDuration: const Duration(seconds: 1),
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              label: 'Dashboard',
              selectedIcon: Icon(Icons.dashboard),
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline),
              label: 'Student',
              selectedIcon: Icon(Icons.people),
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline),
              label: 'Librarian',
              selectedIcon: Icon(Icons.people),
            ),
            NavigationDestination(
              icon: Icon(Icons.people_outline),
              label: 'Admin',
              selectedIcon: Icon(Icons.people),
            ),
            NavigationDestination(
              icon: Icon(Icons.library_books_outlined),
              label: 'Books',
              selectedIcon: Icon(Icons.library_books),
            ),
          ],
        ),
        body: buildBody(context),
      ),
    );
  }

  buildBody(BuildContext buildContext) {
    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is Uploading) {
          ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 5),
              content: Row(
                children: const [
                  CircularProgressIndicator(),
                  Text("   Uploading...")
                ],
              ),
            ),
          );
        }
        if (state is UploadSuccess) {
          showSnackbar(state.message, buildContext);
        }
        if (state is UploadFailed) showSnackbar(state.message, buildContext);
      },
      builder: (context, state) {
        return IndexedStack(
          index: _currentIndex,
          children: ADMIN_PAGES,
        );
      },
    );
  }

  getFAB() {
    return (UserPreferences.getUserRole() == Role.admin.name &&
            _currentIndex > 0 &&
            _currentIndex < 4)
        ? SpeedDial(
            icon: Icons.add,
            spacing: 12,
            spaceBetweenChildren: 12,
            openCloseDial: isDialOpen,
            children: [
              SpeedDialChild(
                  child: const Icon(Icons.person_add_alt_1),
                  label: 'Add A User',
                  onTap: () async {
                    await Navigator.of(context)
                        .push(RegisterPage.route(null, PageMode.addNew))
                        .then((value) {});
                  }),
              SpeedDialChild(
                child: const Icon(Icons.group_add),
                label: 'Bulk Upload',
                onTap: () async => await pickFile(),
              ),
            ],
          )
        : null;
  }
}
