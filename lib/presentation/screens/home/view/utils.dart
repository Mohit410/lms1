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

const ADMIN_DESTINATIONS = [
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
];

const LIBRARIAN_DESTINATIONS = [
  NavigationDestination(
    icon: Icon(Icons.dashboard_outlined),
    label: 'Dashboard',
    selectedIcon: Icon(Icons.dashboard),
  ),
  NavigationDestination(
    icon: Icon(Icons.library_books_outlined),
    label: 'Books',
    selectedIcon: Icon(Icons.library_books),
  ),
  NavigationDestination(
    icon: Icon(Icons.keyboard_return_outlined),
    label: 'Return Book',
    selectedIcon: Icon(Icons.keyboard_return),
  ),
  NavigationDestination(
    icon: Icon(Icons.currency_rupee_outlined),
    label: 'Collect Fine',
    selectedIcon: Icon(Icons.currency_rupee),
  ),
  NavigationDestination(
    icon: Icon(Icons.vpn_key_outlined),
    label: 'Update Password',
    selectedIcon: Icon(Icons.vpn_key),
  ),
];

const STUDENT_DESTINATIONS = [
  NavigationDestination(
    icon: Icon(Icons.dashboard_outlined),
    label: 'Dashboard',
    selectedIcon: Icon(Icons.dashboard),
  ),
  NavigationDestination(
    icon: Icon(Icons.library_books_outlined),
    label: 'Books',
    selectedIcon: Icon(Icons.library_books),
  ),
  NavigationDestination(
    icon: Icon(Icons.vpn_key_outlined),
    label: 'Update Password',
    selectedIcon: Icon(Icons.vpn_key),
  ),
];
