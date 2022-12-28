import 'package:firebase_auth/firebase_auth.dart';

class UserInfo {
  String UserId;
  String UserName;
  String PhoneNumber;
  String Email;
  String ProfileImage = '';
  UserInfo(
      {required this.UserId,
      required this.UserName,
      required this.PhoneNumber,
      required this.Email});
}

// UserInfo user = UserInfo(
//     UserId: FirebaseAuth.instance.currentUser!.uid.toString(),
//     UserName: "Vinayak Ranjane",
//     PhoneNumber: "",
//     Email: FirebaseAuth.instance.currentUser!.email.toString());
