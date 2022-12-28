import 'dart:io';

import 'package:finalbookapp/Providers/Firebase%20Authentication/firebase_storage_provider.dart';
import 'package:finalbookapp/Providers/Firebase%20Authentication/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Constants/products_model.dart';
import '../../Constants/subjects.dart';
import '../../Models/products_model.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  File? image;
  Future addImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final tempPath = File(image.path);
      setState(() {
        this.image = tempPath;
      });
    } catch (e) {
      print(e);
    }
  }

  List<String> sub = [
    "Sem 1",
    "Sem 2",
    "Sem 3",
    "Sem 4",
    "Sem 5",
    "Sem 6",
    "Sem 7",
    "Sem 8",
  ];
  String? valueof;
  String? valueofsub;

  Map<String, String> sliderValueMap = {
    '0': 'Ughh..!',
    '25': 'Managable',
    '50': 'Good',
    '75': 'Rarely used',
    '100': 'Brand New..!',
  };
  double slidervalue = 50;
  final titleCon = TextEditingController();
  final descCon = TextEditingController();
  final priceCon = TextEditingController();
  final newbookKey = GlobalKey<FormState>();

  String phonenNumber = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    valueof = "Sem 1";

    valueofsub = "Engineering Mathematics-I";
    phonenNumber = SharedStorage.getPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    List<String>? subjects = sem[valueof]!.toList();
    print(subjects);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Add New Book.!",
            style: GoogleFonts.poppins(),
          )),
      body: SingleChildScrollView(
          child: Form(
        key: newbookKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Please Wait till The Product gets Uploaded.!",
                style: GoogleFonts.poppins(),
              ),
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.4,
                width: 300,
                child: image == null
                    ? Center(
                        child: CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.blue.shade100,
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.blue.shade400,
                              customBorder: CircleBorder(),
                              onTap: () => addImage(),
                              child: Icon(
                                Icons.add_a_photo,
                                size: 70,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Stack(
                        children: [
                          Center(
                            child: Image.file(
                              image!,
                            ),
                          ),
                          Positioned.fill(
                              child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => addImage(),
                            ),
                          ))
                        ],
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: titleCon,
                validator: (value) {
                  if (value == '') {
                    return "Please Enter Title";
                  } else
                    return null;
                },
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: GoogleFonts.poppins(fontSize: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: descCon,
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: GoogleFonts.poppins(fontSize: 20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 60,
                    width: 100,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      items: sub
                          .map((e) => DropdownMenuItem(
                                child: Text(
                                  e,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold),
                                ),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) => setState(() {
                        this.valueof = value;
                        valueofsub = null;

                        print(subjects);
                      }),
                      value: valueof,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        hintText: "Subject",
                        hintMaxLines: 1,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      items: subjects
                          .map((e) => DropdownMenuItem(
                                child: Text(
                                  e,
                                ),
                                value: e,
                              ))
                          .toList(),
                      onChanged: (value) => setState(() {
                        this.valueofsub = value;
                        print(subjects);
                      }),
                      value: valueofsub,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: priceCon,
                  validator: (value) {
                    if (value == '') {
                      return "Please Enter Price";
                    } else
                      return null;
                  },
                  decoration: InputDecoration(
                      label: Text("Price in Rs"),
                      border: OutlineInputBorder())),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Text("What's the Condition..!?",
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.w500)),
            ),
            Center(
              child: Text(
                  sliderValueMap[slidervalue.toInt().toString()].toString(),
                  style: GoogleFonts.poppins(
                      fontSize: 22, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 10,
            ),
            Slider(
              value: slidervalue,
              onChanged: (value) {
                setState(() {
                  slidervalue = value;
                });
              },
              min: 0,
              max: 100,
              divisions: 4,
              label: sliderValueMap[slidervalue.toInt().toString()],
            ),
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                  onPressed: () async {
                    bool valid = newbookKey.currentState!.validate();
                    print(valid);
                    if (valueofsub == null) {
                      var snackBar = SnackBar(
                          content: Text(
                        "Please Select The Subject..!",
                        style: GoogleFonts.poppins(color: Colors.red),
                      ));

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (image == null) {
                      var snackBar = SnackBar(
                          content: Text(
                        "Please Add an Image..!",
                        style: GoogleFonts.poppins(color: Colors.red),
                      ));

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else if (valid == false) {
                      var snackBar = SnackBar(
                          content: Text(
                        "Please Enter Valid Details..!",
                        style: GoogleFonts.poppins(color: Colors.red),
                      ));

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    } else {
                      print(titleCon.text);
                      print(descCon.text);
                      print(priceCon.text);
                      print(valueof);
                      print(valueofsub);

                      String? downloadUrl = await context
                          .read<FirebaseStorageAPI>()
                          .uploadImageAndGetURL(image!);
                      print(downloadUrl);

                      Product prd = Product(
                        title: titleCon.text,
                        description: descCon.text,
                        price: priceCon.text,
                        condition:
                            sliderValueMap[slidervalue.toInt().toString()]
                                .toString(),
                        semester: valueof.toString(),
                        subject: valueofsub.toString(),
                        image: downloadUrl!,
                        number: phonenNumber,
                        user: context.read<UserProvider>().UserId,
                      );

                      //Add the product to firebase
                      productData.add(prd);
                      myProd.add(prd);
                      print(prd.user);
                      print(prd.number);
                      await context
                          .read<FirebaseStorageAPI>()
                          .uploadProductsToFirebase(product: prd);

                      //above this code
                      SnackBar snackBar = SnackBar(
                          content: Text(
                        "Book Added Succesfully.!",
                        style: GoogleFonts.poppins(color: Colors.green),
                      ));

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      Navigator.pop(context);
                    }
                  },
                  child: Text("Submit")),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      )),
    ));
  }
}
