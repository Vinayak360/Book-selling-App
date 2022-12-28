import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonOutlined extends StatelessWidget {
  final text;
  final VoidCallback tapped;
  const ButtonOutlined({
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blueAccent)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          // onTap: () => Navigator.push(context,
          //     MaterialPageRoute(builder: (context) {
          //   return SignupScreen();
          // })),
          onTap: tapped,
          child: Center(
              child: Text(
            text,
            style: GoogleFonts.poppins(color: Colors.blue),
          )),
        ),
      ),
    );
  }
}
