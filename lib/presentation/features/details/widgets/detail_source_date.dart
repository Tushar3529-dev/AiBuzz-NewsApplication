import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailSourceDate extends StatelessWidget {
  final String source;
  final String date;
  const DetailSourceDate({super.key, required this.source, required this.date});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            source,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Text(
          date,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
