import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isSelected ? Colors.blue : Colors.blueGrey,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Center(
        child: Text(
          textAlign: TextAlign.center,
          label,
          style: GoogleFonts.poppins(fontSize: 13, color: Colors.white),
        ),
      ),
    );
  }
}
