import 'package:flutter/material.dart';
import 'package:lms1/presentation/screens/dashboard/dashboard.dart';

class LogoutAlertDialog extends StatelessWidget {
  const LogoutAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Logout"),
      content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () => _dismis(context),
          child: const Text('CANCEL', style: TextStyle(color: Colors.red)),
        ),
        const ElevatedButton(
          onPressed: DashboardBloc.logout,
          child: Text("LOGOUT", style: TextStyle(color: Colors.blue)),
        )
      ],
    );
  }

  void _dismis(BuildContext context) => Navigator.pop(context);
}
