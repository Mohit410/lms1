import 'package:flutter/material.dart';

const BASEURL = "https://lms-app001.herokuapp.com/";

enum Role {
  student('Student'),
  librarian('Librarian'),
  admin('Admin');

  final String lable;
  const Role(this.lable);
}

enum HttpErrors {
  success,
  created,
  badRequest,
  unauthorized,
  forbidded,
  notFound,
  internalServerError,
  badGateway,
}

enum PageMode { edit, addNew }

enum AppBarColors {
  foregroundColor(Colors.black87),
  backgroundColor(Colors.white);

  final Color color;
  const AppBarColors(this.color);
}
