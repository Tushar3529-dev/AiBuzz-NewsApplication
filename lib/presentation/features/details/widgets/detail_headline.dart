import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailHeadline extends StatelessWidget {
  final String text;
  const DetailHeadline({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 20,
        color: Colors.black87,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
