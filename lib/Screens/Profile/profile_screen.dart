import 'package:finalbookapp/Constants/products_model.dart';
import 'package:finalbookapp/Models/user_info.dart';
import 'package:finalbookapp/Providers/Firebase%20Authentication/firebase_auth_provider.dart';
import 'package:finalbookapp/Providers/Firebase%20Authentication/user_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'add_books_screen.dart';
import 'mybooks_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final NameCont;

  late final PhoneCont;
  late final DetailsKey;
  String userName = '';
  String phonenNumber = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userName = SharedStorage.getUserName();
    phonenNumber = SharedStorage.getPhoneNumber();
    NameCont = TextEditingController();

    PhoneCont = TextEditingController();
    DetailsKey = GlobalKey<FormState>();
  }

  @override
  Widget build(BuildContext context) {
    userName = SharedStorage.getUserName();
    phonenNumber = SharedStorage.getPhoneNumber();
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Center(
                  child: CircleAvatar(
                    radius: 50,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        customBorder: CircleBorder(),
                        onTap: () => print("Tapped on Avatar.!"),
                        child: Icon(
                          Icons.person,
                          size: 70,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(userName,
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w500)),
              Text(
                context.watch<UserProvider>().Email.toString(),
                style: GoogleFonts.poppins(),
              ),
              SizedBox(
                height: 40,
              ),
              Text(phonenNumber,
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w500)),
              ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      context: context,
                      builder: (context) {
                        return SingleChildScrollView(
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: Form(
                              key: DetailsKey,
                              child: Column(
                                children: [
                                  Icon(Icons.arrow_drop_down),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: TextFormField(
                                      autofocus: true,
                                      controller: NameCont,
                                      validator: (value) {
                                        if (value == '') {
                                          return "Please Enter Username";
                                        } else
                                          return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Name",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: TextFormField(
                                      controller: PhoneCont,
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value!.length != 10) {
                                          return "Please Enter Correct Number";
                                        } else
                                          return null;
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Phone Number",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 43,
                                    width: 120,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff0C63E7),
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(12),
                                        onTap: () {
                                          bool valid = DetailsKey.currentState!
                                              .validate();
                                          print(valid);

                                          if (valid == false) {
                                            SnackBar snackBar = SnackBar(
                                                content: Text(
                                              "Please Enter Your Valid Details.!",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.red),
                                            ));

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          } else {
                                            print("Tapped on Submit Button");

                                            context
                                                .read<UserProvider>()
                                                .editUserDetails(
                                                    NameCont.text.trim(),
                                                    PhoneCont.text.trim());

                                            setState(() {});
                                            SharedStorage.setPhoneNumber(
                                                PhoneCont.text.trim());
                                            SharedStorage.setUsername(
                                                NameCont.text.trim());
                                            setState(() {});
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            Text(
                                              "SUBMIT",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("EDIT DETAILS"),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(Icons.edit)
                    ],
                  )),
              //implement LogOut Button
              Container(
                height: 43,
                width: 120,
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
                    onTap: () => context.read<FirebaseLoginProvider>().logOut(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          "LOGOUT",
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Material(
                elevation: 4,
                shadowColor: Colors.blue,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    child: Center(
                        child: Text('My Books',
                            style: GoogleFonts.poppins(
                                fontSize: 18, fontWeight: FontWeight.w600))),
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MyBooksScreen();
                    })),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                elevation: 5,
                shadowColor: Colors.blue,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(12)),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      child: Center(
                          child: Text('Add Books',
                              style: GoogleFonts.poppins(
                                  fontSize: 18, fontWeight: FontWeight.w600))),
                      onTap: () {
                        if (phonenNumber == '') {
                          SnackBar snackBar = SnackBar(
                              content: Text(
                            "Please Enter Your Profile Details.!",
                            style: GoogleFonts.poppins(color: Colors.red),
                          ));

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AddBookScreen();
                          }));
                        }
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
