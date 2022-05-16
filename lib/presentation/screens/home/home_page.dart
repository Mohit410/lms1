import 'package:flutter/material.dart';
import 'package:lms1/presentation/screens/admin_list/view/admin_list_page.dart';
import 'package:lms1/presentation/screens/book_list/view/view.dart';
import 'package:lms1/presentation/screens/dashboard/dashboard.dart';
import 'package:lms1/presentation/screens/home/local_widget/navigation_drawer.dart';
import 'package:lms1/presentation/screens/librarian_list/view/librarian_list_page.dart';
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
  int _currentIndex = 0;
  List<Widget> pages = const [
    DashboardPage(),
    StudentListPage(),
    LibrarianListPage(),
    AdminListPage(),
    BookListPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      drawer: const NavigationDrawerWidget(),
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
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),
    );
  }
}
