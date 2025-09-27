import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailDescription extends StatelessWidget {
  final String text;
  const DetailDescription({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 15,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
