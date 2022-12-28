import 'dart:ffi';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:finalbookapp/Providers/Firebase%20Authentication/firebase_storage_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/products_model.dart';
import '../../Models/products_model.dart';

class DetailsScreen extends StatefulWidget {
  final index;
  final Product product;

  const DetailsScreen({Key? key, required this.index, required this.product})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  static bool isfavourite = false;
  static bool myprod = false;
  static void isfav(String prdId) {
    print("printing ids:${prdId}");
    for (var i = 0; i < favProd.length; i++) {
      if (favProd[i] == prdId) {
        isfavourite = true;
      }
    }
    print("initstate: $isfavourite");
  }

  static isMyProd(Product prod) {
    if (prod.user == FirebaseAuth.instance.currentUser!.uid) {
      myprod = true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("inside init state:");
    isfav(widget.product.uniqueID);
    isMyProd(widget.product);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isfavourite = false;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.product.uniqueID);

    print(isfavourite);
    print("This is My Product:$myprod");

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Stack(
          children: [
            Hero(
              tag: widget.index,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: CachedNetworkImage(
                  imageUrl: widget.product.image,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(0, -4),
                              blurRadius: 5)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Center(
                                child: Text(
                                  widget.product.title,
                                  style: GoogleFonts.poppins(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            //
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                margin: const EdgeInsets.only(right: 12),
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Rs. ${widget.product.price}/-",
                                    style: GoogleFonts.poppins(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            const Divider(thickness: 2),
                            const SizedBox(
                              height: 12,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 12),
                              child: Text(
                                widget.product.description,
                                style: GoogleFonts.poppins(
                                    color: Colors.grey.shade600),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 12,
                                ),
                                child: Wrap(
                                  children: [
                                    Text(
                                      "Condition: ",
                                      style: GoogleFonts.poppins(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      widget.product.condition,
                                      style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            const SizedBox(
                              height: 100,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 4,
                    bottom: 10,
                    right: MediaQuery.of(context).size.width / 4,
                    child: Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12)),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            if (myprod == false) {
                              OpenWhatsApp(widget.product);
                            } else {
                              context
                                  .read<FirebaseStorageAPI>()
                                  .deleteImageFromStorage(widget.product.image);

                              context
                                  .read<FirebaseStorageAPI>()
                                  .deleteMyProduct(widget.product.uniqueID)
                                  .then((value) {
                                setState(() {});
                              });
                              SnackBar snackBar = SnackBar(
                                  content: Text(
                                "Book Deleted Succesfully.!",
                                style: GoogleFonts.poppins(color: Colors.green),
                              ));

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              Navigator.pop(context);
                            }
                          },
                          child: Center(
                              child: myprod == false
                                  ? Text(
                                      "WhatsApp",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      "Remove Product",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              right: 15,
              top: MediaQuery.of(context).size.height * 0.4,
              child: Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isfavourite
                      ? const Color.fromARGB(255, 238, 158, 158)
                      : const Color.fromARGB(255, 224, 222, 222),
                  // borderRadius: BorderRadius.circular(100),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    splashColor: const Color.fromARGB(255, 238, 158, 158),
                    onTap: () {
                      setState(() {
                        isfavourite = !isfavourite;
                        if (isfavourite) {
                          favProd.add(widget.product.uniqueID);
                          context
                              .read<FirebaseStorageAPI>()
                              .addFavourites(favProd);
                        } else if (isfavourite == false) {
                          favProd.remove(widget.product.uniqueID);
                          context
                              .read<FirebaseStorageAPI>()
                              .addFavourites(favProd);
                        } else
                          print("Some Error");
                      });
                    },
                    child: Icon(
                      Icons.favorite,
                      size: 30,
                      color: isfavourite
                          ? const Color.fromARGB(255, 241, 53, 53)
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OpenWhatsApp(Product product) async {
    var Number = "+91${product.number}";
    var bookName = product.title;
    print(product.number);
    var url =
        "https://wa.me/${Number}?text=Hello ,I would like to Buy Your book:\n$bookName";

    await launch(url);
  }
}
