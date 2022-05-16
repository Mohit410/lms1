import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DashbaordCard extends StatelessWidget {
  final String title;
  final String data;
  final String svgSrc;
  final Color color;
  const DashbaordCard({
    Key? key,
    required this.title,
    required this.data,
    required this.svgSrc,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        border: Border.all(width: 2, color: color.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            //padding: const EdgeInsets.all(12),
            height: 36,
            width: 36,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset(
              svgSrc,
              color: color,
            ),
          ),
          const Spacer(),
          Text(
            title,
            style: GoogleFonts.lato(fontSize: 16),
            overflow: TextOverflow.clip,
          ),
          const SizedBox(height: 10),
          Text(data, style: GoogleFonts.lato(fontSize: 16)),
        ],
      ),
    );
  }
}
