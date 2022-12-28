import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionPapersTab extends StatelessWidget {
  const QuestionPapersTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  print("Tapped on Question paper: $index");
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 80,
                    width: MediaQuery.of(context).size.width - 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 2),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        "March 202$index",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ));
          },
          itemCount: 7,
        ),
      ),
    );
  }
}
