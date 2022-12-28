import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Widgets/Home/sem_sub_card.dart';
import 'tab_view.dart';

class SubjectSelectionScreen extends StatelessWidget {
  final Map sem;
  final String keyofMap;
  final int i;
  const SubjectSelectionScreen(
      {Key? key, required this.sem, required this.keyofMap, required this.i})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "SELECT THE SUBJECT..",
                  style: GoogleFonts.montserrat(
                      fontSize: 26,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.8),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.8,
                padding: const EdgeInsets.only(bottom: 20),
                width: double.maxFinite,
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  itemCount: sem[keyofMap].length,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  padding: const EdgeInsets.only(bottom: 10),
                  itemBuilder: (ctx, index) {
                    return SemCard(
                      tap: () {
                        print("Sem ${index + 1}");
                        print(
                            "$i , Subject: ${sem[keyofMap][index].toString()}");

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return TabViewScreen(
                            semester: keyofMap,
                            subject: sem[keyofMap][index].toString(),
                          );
                        }));
                      },
                      color: index % 2 == 0
                          ? Color(0xff00FF94)
                          : Color(0xff007DFE),
                      text: sem[keyofMap][index].toString(),
                      cheight: index % 2 == 0 ? 250 : 215,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
