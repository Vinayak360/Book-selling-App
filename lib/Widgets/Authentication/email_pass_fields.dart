import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PassFields extends StatefulWidget {
  final text;
  final TextEditingController titleCon;

  const PassFields({
    Key? key,
    required this.titleCon,
    required this.text,
  }) : super(key: key);

  @override
  State<PassFields> createState() => _PassFieldsState();
}

class _PassFieldsState extends State<PassFields> {
  bool passVisible = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 5),
            child: Text(
              widget.text,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.blue),
            ),
          ),
          Container(
            child: TextFormField(
              obscureText: !passVisible,
              controller: widget.titleCon,
              validator: (val) {
                if (val!.length < 7) {
                  return "Password should be atleast 7 characters.!";
                } else
                  return null;
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => setState(() {
                    passVisible = !passVisible;
                  }),
                  icon: passVisible
                      ? Icon(
                          Icons.visibility,
                          color: Colors.blue,
                        )
                      : Icon(
                          Icons.visibility_off,
                          color: Colors.grey,
                        ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
    required this.titleCon,
  }) : super(key: key);

  final TextEditingController titleCon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 5),
            child: Text(
              "Email",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.blue),
            ),
          ),
          Container(
            child: TextFormField(
              controller: titleCon,
              validator: (val) {
                final patter =
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                final regex = RegExp(patter);
                if (regex.hasMatch(titleCon.text)) {
                  return null;
                } else
                  return "Enter Correct Email..!";
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: BorderSide(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
