import 'package:finalbookapp/Constants/products_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Constants/subjects.dart';
import '../../Providers/Firebase Authentication/firebase_auth_provider.dart';
import '../../Providers/Firebase Authentication/user_provider.dart';
import '../../Widgets/Home/sem_sub_card.dart';
import 'subjects_selection.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  late String name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = SharedStorage.getUserName();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 15),
                child: Text(
                  "Hi, $name",
                  style: GoogleFonts.poppins(
                      fontSize: 24, fontWeight: FontWeight.w300),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  "WHICH SEMESTER\nYOU ARE IN..?",
                  style: GoogleFonts.montserrat(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.5),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.7,
                padding: const EdgeInsets.only(bottom: 20),
                width: double.maxFinite,
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  itemCount: 8,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  padding: const EdgeInsets.only(bottom: 20),
                  itemBuilder: (ctx, index) {
                    return SemCard(
                      tap: () {
                        print("sem${index + 1}");

                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SubjectSelectionScreen(
                            sem: sem,
                            keyofMap: "Sem ${index + 1}",
                            i: index + 1,
                          );
                        }));
                      },
                      color: index % 2 == 0
                          ? Color(0xff00FF94)
                          : Color(0xff007DFE),
                      text: "Sem ${index + 1}",
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
