import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/presentation/components/utils/helper.dart';
import 'package:lms1/presentation/screens/add_new_book/add_new_book.dart';
import 'package:lms1/presentation/screens/book_list/book_list.dart';
import 'package:lms1/presentation/screens/home/home.dart';
import 'package:lms1/presentation/screens/register/register.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late NavigationBloc _bloc;
  final isDialOpen = ValueNotifier(false);

  int _currentIndex = 0;

  late ScaffoldFeatureController<SnackBar, SnackBarClosedReason> controller;

  @override
  void initState() {
    _bloc = BlocProvider.of<NavigationBloc>(context);
    super.initState();
  }

  pickFile(String fileFor) async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return;

    final file = result.files.single;
    final supportedFiles = ['xls', 'xlsx'];
    if (supportedFiles.contains(file.extension)) {
      if (fileFor == 'books') {
        _bloc.add(UploadBulkBooks(result.files.single));
      }
      if (fileFor == 'users') {
        _bloc.add(UploadBulkUsers(result.files.single));
      }
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
        floatingActionButton: _getFAB(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          showUnselectedLabels: true,
          unselectedLabelStyle: const TextStyle(
            overflow: TextOverflow.clip,
          ),
          selectedLabelStyle: const TextStyle(
            overflow: TextOverflow.clip,
          ),
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: _getDestinations(),
        ),
        body: _buildBody(context),
      ),
    );
  }

  _buildBody(BuildContext buildContext) {
    return BlocConsumer<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state is Uploading) {
          controller = ScaffoldMessenger.of(buildContext).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 20),
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
          controller.close();
          showSnackbar(state.message, buildContext);
        }
        if (state is UploadFailed) {
          controller.close();
          showSnackbar(state.message, buildContext);
        }
      },
      builder: (context, state) {
        return _getPages()[_currentIndex];
      },
    );
  }

  _getPages() {
    if (UserPreferences.userRole == Role.admin.name) {
      return ADMIN_PAGES;
    } else if (UserPreferences.userRole == Role.librarian.name) {
      return LIBRARIAN_PAGES;
    } else {
      return STUDENT_PAGES;
    }
  }

  _getFAB() {
    if (UserPreferences.userRole == Role.admin.name) {
      return (_currentIndex > 0 && _currentIndex < 4)
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
                  onTap: () async => await pickFile('users'),
                ),
              ],
            )
          : null;
    } else if (UserPreferences.userRole == Role.librarian.name) {
      return (_currentIndex == 1)
          ? SpeedDial(
              icon: Icons.add,
              spacing: 12,
              spaceBetweenChildren: 12,
              openCloseDial: isDialOpen,
              children: [
                SpeedDialChild(
                    child: const Icon(Icons.book),
                    label: 'Add A Book',
                    onTap: () async {
                      await Navigator.of(context)
                          .push(
                        AddNewBookPage.route(null, PageMode.addNew),
                      )
                          .then((value) {
                        if (value == 'refresh') {
                          BlocProvider.of<BookListBloc>(context)
                              .add(FetchBooks());
                        }
                      });
                    }),
                SpeedDialChild(
                  child: const Icon(Icons.my_library_books),
                  label: 'Bulk Upload',
                  onTap: () async => await pickFile('books'),
                ),
              ],
            )
          : null;
    } else if (UserPreferences.userRole == Role.student.name) {
      return null;
    } else {
      return null;
    }
  }

  List<BottomNavigationBarItem> _getDestinations() {
    if (UserPreferences.userRole == Role.admin.name) {
      return ADMIN_DESTINATIONS;
    } else if (UserPreferences.userRole == Role.librarian.name) {
      return LIBRARIAN_DESTINATIONS;
    } else if (UserPreferences.userRole == Role.student.name) {
      return STUDENT_DESTINATIONS;
    }
    return [];
  }
}
