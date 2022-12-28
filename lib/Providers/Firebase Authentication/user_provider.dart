import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/user_info.dart' as uf;

class UserProvider with ChangeNotifier {
  String UserId = FirebaseAuth.instance.currentUser!.uid.toString();
  String UserName = '';
  String PhoneNumber = '';
  String Email = FirebaseAuth.instance.currentUser!.email.toString();
  String ProfileImage = '';
  // UserProvider(
  //     {required this.UserId,
  //     required this.UserName,
  //     required this.PhoneNumber,
  //     required this.Email});

  // UserProvider user = UserProvider(
  //     UserId: FirebaseAuth.instance.currentUser!.uid.toString(),
  //     UserName: "Vinayak Ranjane",
  //     PhoneNumber: "",
  //     Email: FirebaseAuth.instance.currentUser!.email.toString());

  void editUserDetails(var name, var phonenumber) {
    this.PhoneNumber = phonenumber;
    this.UserName = name;
  }
}
