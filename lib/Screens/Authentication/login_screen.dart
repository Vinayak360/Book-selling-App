import 'package:finalbookapp/Providers/Firebase%20Authentication/firebase_auth_provider.dart';
import 'package:finalbookapp/Screens/Authentication/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Widgets/Authentication/button_filled.dart';
import '../../Widgets/Authentication/button_outlined.dart';
import '../../Widgets/Authentication/email_pass_fields.dart';
import 'package:finalbookapp/Providers/Firebase Authentication/firebase_auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController titleCon;
  late TextEditingController passCon;
  late TextEditingController confirmCon;

  final loginkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleCon = TextEditingController();
    passCon = TextEditingController();
    confirmCon = TextEditingController();
  }

  @override
  void dispose() {
    titleCon.dispose();
    passCon.dispose();
    confirmCon.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Form(
          key: loginkey,
          child: Column(
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Image.asset("assets/loginimage.png"),
              )),
              const SizedBox(
                height: 6,
              ),
              Text(
                "LOGIN",
                style: GoogleFonts.poppins(fontSize: 36, color: Colors.blue),
              ),
              const SizedBox(
                height: 12,
              ),
              EmailField(titleCon: titleCon),
              PassFields(
                titleCon: passCon,
                text: "Password",
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Buttonfilled(
                    text: "LOGIN",
                    tapped: () {
                      bool valid = loginkey.currentState!.validate();
                      if (valid == false) {
                      } else {
                        context.read<FirebaseLoginProvider>().login(
                            titleCon.text.trim(), passCon.text.trim(), context);
                      }
                    },
                  ),
                  ButtonOutlined(
                    tapped: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const SignupScreen();
                      }));
                    },
                    text: "CREATE",
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
