import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 50,
          width: 120,
          decoration: BoxDecoration(
              color: Colors.deepPurple.shade700,
              borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.lato(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
