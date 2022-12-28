import 'package:finalbookapp/Providers/Firebase%20Authentication/firebase_storage_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Models/products_model.dart';
import '../../Home/products_card.dart';

class BuyBooksTab extends StatelessWidget {
  const BuyBooksTab({
    Key? key,
    required this.semester,
    required this.subject,
  }) : super(key: key);

  final semester;
  final subject;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<List<Product>>(
            stream: context
                .read<FirebaseStorageAPI>()
                .readProductData(semester, subject),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final products = snapshot.data!.toList();
                print(products[0].number);
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return ProductCard(
                      prd: products[index],
                      index: index,
                    );
                  },
                  itemCount: products.length != 0 ? products.length : 0,
                );
              } else if (snapshot.hasError) {
                return Text("Something Went Wrong");
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
    );
  }
}
