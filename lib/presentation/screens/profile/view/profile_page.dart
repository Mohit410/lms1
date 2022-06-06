import 'package:flutter/material.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/presentation/components/utils/helper.dart';

class ProfilePage extends StatelessWidget {
  static Route route(UserModel user) =>
      MaterialPageRoute(builder: (_) => ProfilePage(user: user));

  final UserModel user;
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(user.name),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  headingText('Role'),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  fieldText(user.role.capitalize()),
                  const SizedBox(height: 16),
                  headingText('Name'),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  fieldText(user.name),
                  const SizedBox(height: 16),
                  headingText('Email'),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  fieldText(user.email),
                  const SizedBox(height: 16),
                  headingText('Phone'),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  fieldText(user.phone),
                  const SizedBox(height: 16),
                  headingText('Address'),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  fieldText(user.address),
                  const SizedBox(height: 16),
                  headingText('City'),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  fieldText(user.city),
                  const SizedBox(height: 16),
                  headingText('State'),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  fieldText(user.state),
                  const SizedBox(height: 16),
                  headingText('Pincode'),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  fieldText(user.pincode),
                ]),
          ),
        ));
  }
}
