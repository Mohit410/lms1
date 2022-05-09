import 'package:flutter/material.dart';

customAppBar({
  required String titleText,
  double? elevation,
  bool? noLeading = false,
  Widget? leading,
  required BuildContext context,
}) =>
    AppBar(
      title: Text(titleText),
      elevation: elevation ?? 0,
      leading: (noLeading!)
          ? null
          : leading ??
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back),
              ),
    );
