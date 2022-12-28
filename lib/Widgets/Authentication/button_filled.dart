import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Buttonfilled extends StatelessWidget {
  final text;
  final VoidCallback tapped;
  const Buttonfilled({
    Key? key,
    required this.text,
    required this.tapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 43,
      width: 95,
      decoration: BoxDecoration(
          color: const Color(0xff0C63E7),
          borderRadius: BorderRadius.circular(12)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          // onTap: () => Navigator.pushReplacement(context,
          //     MaterialPageRoute(builder: (context) {
          //   return MainHomeScreen();
          // })),
          onTap: tapped,
          child: Center(
              child: Text(
            text,
            style: GoogleFonts.poppins(color: Colors.white),
          )),
        ),
      ),
    );
  }
}
