import 'package:flutter/material.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/presentation/screens/admin_list/admin_list.dart';
import 'package:lms1/presentation/screens/book_list/book_list.dart';
import 'package:lms1/presentation/screens/collect_fine/collect_fine.dart';
import 'package:lms1/presentation/screens/dashboard/dashboard.dart';
import 'package:lms1/presentation/screens/librarian_list/librarian_list.dart';
import 'package:lms1/presentation/screens/return_book/view/return_book_page.dart';
import 'package:lms1/presentation/screens/student_list/student_list.dart';
import 'package:lms1/presentation/screens/update_password/update_password.dart';

const ADMIN_PAGES = [
  DashboardPage(),
  StudentListPage(),
  LibrarianListPage(),
  AdminListPage(),
  BookListPage(),
];

final STUDENT_PAGES = [
  const DashboardPage(),
  const BookListPage(),
  UpdatePasswordPage(
      email: UserPreferences.userEmail!, role: UserPreferences.userRole!),
];

final LIBRARIAN_PAGES = [
  const DashboardPage(),
  const BookListPage(),
  const ReturnBookPage(),
  const CollectFinePage(),
  UpdatePasswordPage(
      email: UserPreferences.userEmail!, role: UserPreferences.userRole!),
];

final ADMIN_DESTINATIONS = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.dashboard_outlined),
    label: 'Dashboard',
    activeIcon: Icon(Icons.dashboard),
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.people_outline),
    label: 'Student',
    activeIcon: Icon(Icons.people),
  ),
  BottomNavigationBarItem(
    icon: Image.asset('assess/images/librarian.png'),
    label: 'Librarian',
    activeIcon: Image.asset('assess/images/librarian.png'),
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.admin_panel_settings_outlined),
    label: 'Admin',
    activeIcon: Icon(Icons.admin_panel_settings),
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.library_books_outlined),
    label: 'Books',
    activeIcon: Icon(Icons.library_books),
  ),
];

final LIBRARIAN_DESTINATIONS = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.dashboard_outlined),
    label: 'Dashboard',
    activeIcon: Icon(Icons.dashboard),
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.library_books_outlined),
    label: 'Books',
    activeIcon: Icon(Icons.library_books),
  ),
  const BottomNavigationBarItem(
      icon: Icon(Icons.keyboard_return_outlined),
      label: 'Return Book',
      activeIcon: Icon(Icons.keyboard_return)),
  const BottomNavigationBarItem(
    icon: Icon(Icons.currency_rupee_outlined),
    label: 'Collect Fine',
    activeIcon: Icon(Icons.currency_rupee),
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.vpn_key_outlined),
    label: 'Update  Password',
    activeIcon: Icon(Icons.vpn_key),
  ),
];

const STUDENT_DESTINATIONS = [
  BottomNavigationBarItem(
    icon: Icon(Icons.dashboard_outlined),
    label: 'Dashboard',
    activeIcon: Icon(Icons.dashboard),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.library_books_outlined),
    label: 'Books',
    activeIcon: Icon(Icons.library_books),
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.vpn_key_outlined),
    label: 'Update Password',
    activeIcon: Icon(Icons.vpn_key),
  ),
];
