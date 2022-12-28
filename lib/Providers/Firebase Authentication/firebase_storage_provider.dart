import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalbookapp/Constants/products_model.dart';
import 'package:finalbookapp/Models/products_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FirebaseStorageAPI with ChangeNotifier {
  Future<String?> uploadImageAndGetURL(File file) async {
    String imageURL;
    try {
      final ref = FirebaseStorage.instance.ref(
          'ImagesProduct/${DateTime.now().millisecondsSinceEpoch.toString() + '.jpg'}');
      UploadTask uploadTask = ref.putFile(file);
      final snapshot = await uploadTask.whenComplete(() {});
      imageURL = await snapshot.ref.getDownloadURL();
      return imageURL;
    } on FirebaseException catch (e) {
      print(e);
      return null;
    }
  }

  Future uploadProductsToFirebase({required Product product}) async {
    final docrRef = FirebaseFirestore.instance.collection('Products').doc();

    product.uniqueID = docrRef.id;

    final convertedToJSON = product.toJson();
    await docrRef.set(convertedToJSON);
  }

  Stream<List<Product>> readProductData(String semester, String sub) =>
      FirebaseFirestore.instance
          .collection('Products')
          .where('semester', isEqualTo: semester)
          .where('subject', isEqualTo: sub)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Product.fromJson(doc.data()))
              .toList());

  Stream<List<Product>> readFavProds() => FirebaseFirestore.instance
      .collection('Products')
      .where('uniqueID', whereIn: favProd)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            return Product.fromJson(doc.data());
          }).toList());

  Future addFavourites(List<dynamic> favs) async {
    final docrRef = FirebaseFirestore.instance
        .collection('Favourites')
        .doc(FirebaseAuth.instance.currentUser!.uid);

    Map<String, dynamic> data = {'UserFavs': favs};

    await docrRef.set(data);
  }

  Future<List<dynamic>?> getFavList() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('Favourites')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (snapshot.exists) {
        return snapshot.data()!['UserFavs'];
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<List<Product>> readMyProds() => FirebaseFirestore.instance
      .collection('Products')
      .where('user',
          isEqualTo: FirebaseAuth.instance.currentUser!.uid.toString())
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            return Product.fromJson(doc.data());
          }).toList());

  Future deleteMyProduct(String UniqueID) {
    return FirebaseFirestore.instance
        .collection("Products")
        .doc(UniqueID)
        .delete()
        .then((value) => print("Deleted Product Provider"));
  }

  Future deleteImageFromStorage(String url) {
    return FirebaseStorage.instance.refFromURL(url).delete();
  }

  Future<void> downloadSyllabus(String semester) async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File('${appDocDir.path}/$semester-syllabus.pdf');

    try {
      await FirebaseStorage.instance
          .ref('Syllabus/$semester-syllabus.pdf')
          .writeToFile(downloadToFile);

      print(downloadToFile.path);

      OpenFile.open(downloadToFile.path);
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
