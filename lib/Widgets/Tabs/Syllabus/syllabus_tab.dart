import 'package:finalbookapp/Providers/Firebase%20Authentication/firebase_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SyllabusTab extends StatelessWidget {
  final semester;
  const SyllabusTab({
    Key? key,
    required this.semester,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () async {
                  print(semester);
                  await context
                      .read<FirebaseStorageAPI>()
                      .downloadSyllabus(semester);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) {
                  //   return PDFViewScreen();
                  // }));
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
                        "Syllabus",
                        style: GoogleFonts.poppins(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ));
          },
          itemCount: 1,
        ),
      ),
    );
  }
}
