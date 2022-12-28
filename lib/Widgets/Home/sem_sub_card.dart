import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SemCard extends StatelessWidget {
  final Color color;
  final String text;
  final double cheight;
  final VoidCallback tap;

  const SemCard({
    Key? key,
    required this.color,
    required this.text,
    required this.cheight,
    required this.tap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cheight,
      width: 170,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, 4), blurRadius: 4)
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          splashColor: Colors.white.withOpacity(0.3),
          onTap: tap,
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
