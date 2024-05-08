import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/resources/cloudfirestore_methods.dart';
import 'package:amazon_clone/screens/payment_screen.dart';
import 'package:amazon_clone/utils/color_theme.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widget/cart_item_widget.dart';
import 'package:amazon_clone/widget/custom_button.dart';
import 'package:amazon_clone/widget/search_bar_widget.dart';
import 'package:amazon_clone/widget/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: SearchBarWidget(isReadOnly: true, hasBackButton: false),
      body: Center(
        child: Column(
          children: [
            const UserDetailsBar(offset: 0, screen: 'cart'),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("cart")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  Utils().showSnackBar(
                      context: context, content: snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CustomMainButton(
                    color: yellowColor,
                    isLoading: true,
                    onPressed: () {},
                    child: const Text(
                      'Proceed to buy',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                } else {
                  return CustomMainButton(
                    color: yellowColor,
                    isLoading: false,
                    onPressed: () async {
                      //buy function
                      double totalPrice = await CloudFirestoreMethods()
                          .totalPricefromCart(context);
                      totalPrice != 0
                          ? Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PaymentScreen(
                                    price: totalPrice, orderAll: true),
                              ),
                            )
                          : Utils().showSnackBar(
                              context: context, content: 'cart is empty');
                    },
                    child: const Text(
                      'Proceed to buy',
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }
              },
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("cart")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  Utils().showSnackBar(
                      context: context, content: snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return snapshot.hasData
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              ProductModel model =
                                  ProductModel.getModelFromJson(snapshot
                                      .data!.docs[index]
                                      .data()['product']);
                              int count =
                                  snapshot.data!.docs[index].data()['count'];
                              return CartItemWidget(
                                model: model,
                                itemCount: count,
                                cartScreenctx: context,
                              );
                            },
                          ),
                        )
                      : Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
