import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Constants/products_model.dart';
import '../../Models/products_model.dart';
import '../../Providers/Firebase Authentication/firebase_storage_provider.dart';
import '../../Widgets/Home/products_card.dart';
import '../Home/product_details_screen.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getFavData();
  }

  Future<void> getFavData() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Favourites')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    var datafromFirebase = snapshot.data();

    setState(() {
      favProd = datafromFirebase!['UserFavs'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print("The value of FavProd is:$favProd");
    return Scaffold(
      appBar: AppBar(
        title: Text("Favourite Books"),
        centerTitle: true,
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: favProd.length == 0
              ? Text('No Favourite Products')
              : StreamBuilder<List<Product>>(
                  stream: context.read<FirebaseStorageAPI>().readFavProds(),
                  builder: (context, snapshot) {
                    print("The data is :${snapshot.data}");
                    if (snapshot.hasData) {
                      final prd = snapshot.data!;

                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 90,
                            width: MediaQuery.of(context).size.width - 40,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () => Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return DetailsScreen(
                                    index: index,
                                    product: prd[index],
                                  );
                                })).then((_) {
                                  setState(() {});
                                }),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Hero(
                                      tag: index,
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        height: 70,
                                        width: 70,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          border: Border.all(
                                              color: Colors.grey.shade400),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: CachedNetworkImage(
                                            imageUrl: prd[index].image,
                                            fit: BoxFit.cover,
                                            placeholder: (context, url) =>
                                                const CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                160,
                                            child: Text(
                                              prd[index].title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Text(
                                            prd[index].condition,
                                            style: GoogleFonts.poppins(
                                                color: Colors.grey),
                                          ),
                                          Text("Rs: ${prd[index].price}/",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: prd.length,
                      );
                    } else if (snapshot.hasError) {
                      return Text("Something Went Wrong");
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
        ),
      ),
    );
  }
}
