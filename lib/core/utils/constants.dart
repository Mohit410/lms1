import 'package:flutter/material.dart';

const BASEURL = "https://lms-app001.herokuapp.com/";

enum Role {
  student('Student'),
  librarian('Librarian'),
  admin('Admin');

  final String lable;
  const Role(this.lable);
}

enum BookCategory {
  education('Education'),
  music('Music'),
  sport('Sport');

  final String lable;
  const BookCategory(this.lable);
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
