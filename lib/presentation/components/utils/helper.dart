import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackbar(String message, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

const rupeeSymbol = "\u{20B9}";

headingText(String value) => Text(
      value,
      style: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      textAlign: TextAlign.start,
    );

fieldText(String value) => Text(
      value,
      style: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.start,
    );

coloredFieldText(String value) => Text(
      value,
      style: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.blue.shade400,
      ),
      textAlign: TextAlign.start,
    );
