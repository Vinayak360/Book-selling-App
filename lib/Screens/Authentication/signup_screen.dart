import 'package:finalbookapp/Providers/Firebase%20Authentication/firebase_auth_provider.dart';
import 'package:finalbookapp/Screens/Authentication/login_screen.dart';
import 'package:finalbookapp/Screens/Authentication/wrapper.dart';
import 'package:finalbookapp/Widgets/Authentication/button_filled.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../../Widgets/Authentication/email_pass_fields.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController titleCon;
  late TextEditingController passCon;
  late TextEditingController confirmCon;

  final signupkey = GlobalKey<FormState>();

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
          key: signupkey,
          child: Column(
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Image.asset("assets/signupimage.png"),
              )),
              const SizedBox(
                height: 6,
              ),
              Text(
                "SIGN-UP",
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
              PassFields(
                titleCon: confirmCon,
                text: "Confirm Password",
              ),
              const SizedBox(
                height: 12,
              ),
              Buttonfilled(
                  text: "LOGIN",
                  tapped: () async {
                    bool valid = signupkey.currentState!.validate();
                    String message = 'Password does not match.!';

                    final snackBar = SnackBar(
                        content: Text(
                      message,
                      style: GoogleFonts.poppins(color: Colors.red),
                    ));
                    if (passCon.text != confirmCon.text) {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (valid == false) {
                      final snackBar = SnackBar(
                          content: Text(
                        "Please Enter Valid Details..!",
                        style: GoogleFonts.poppins(color: Colors.red),
                      ));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      await context.read<FirebaseLoginProvider>().makeAccount(
                          titleCon.text.trim(),
                          confirmCon.text.trim(),
                          context);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const WrapperAuth();
                      }));
                    }
                  }),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        )),
      ),
    );
  }
}
