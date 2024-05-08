import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/screens/product_screen.dart';
import 'package:amazon_clone/screens/result_screen.dart';
import 'package:amazon_clone/utils/color_theme.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProductShowCaseList extends StatelessWidget {
  final String title;
  final String screen;
  final List<ProductModel> list;

  const ProductShowCaseList(
      {super.key,
      required this.title,
      required this.list,
      required this.screen});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize(context);
    double height = (screenSize.height / 4) + 10;

    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      height: height,
      width: screenSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 25,
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                screen == 'home'
                    ? Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const ResultScreen(
                                query: '',
                                screen: 'home',
                              ),
                            ));
                          },
                          child: const Text(
                            ' Show more',
                            style: TextStyle(color: activeCyanColor),
                          ),
                        ),
                      )
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      )
              ],
            ),
          ),
          SizedBox(
            height: height - 41,
            width: screenSize.width,
            child: screen != 'profile'
                ? ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ProductScreen(model: list[index]),
                          ));
                        },
                        child: Card(
                          elevation: 10,
                          child: Image.asset(list[index].image),
                        ),
                      );
                    },
                  )
                : StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection('orders')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        Utils().showSnackBar(
                            context: context,
                            content: snapshot.error.toString());
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else {
                        return snapshot.hasData
                            ? snapshot.data!.docs.isNotEmpty
                                ? ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      ProductModel productModel =
                                          ProductModel.getModelFromJson(snapshot
                                              .data!.docs[index]
                                              .data());
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                            builder: (context) => ProductScreen(
                                                model: productModel),
                                          ));
                                        },
                                        child: Card(
                                          elevation: 10,
                                          child:
                                              Image.asset(productModel.image),
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    width: screenSize.width / 3,
                                    decoration: const BoxDecoration(),
                                    child: Image.asset(
                                        'assets/images/noOrders.jpg'),
                                  )
                            : Container(
                                width: screenSize.width / 3,
                                decoration: const BoxDecoration(),
                                child:
                                    Image.asset('assets/images/noOrders.jpg'),
                              );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
