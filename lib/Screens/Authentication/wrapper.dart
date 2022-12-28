import 'package:finalbookapp/Screens/Authentication/login_screen.dart';
import 'package:finalbookapp/Widgets/bottom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Home/home_screen.dart';

class WrapperAuth extends StatelessWidget {
  const WrapperAuth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const MainHomeScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
