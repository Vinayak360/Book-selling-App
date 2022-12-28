import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BooksPDFTab extends StatelessWidget {
  const BooksPDFTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              width: 180,
              height: 190,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  Center(child: Image.asset("assets/book.jpg")),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: 70,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.3),
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Erwin Kreyszig",
                            style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          ElevatedButton(
                              onPressed: () {}, child: Text("Download"))
                        ],
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
