import 'package:amazon_clone/model/product_model.dart';
import 'package:amazon_clone/model/user_details_model.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CloudFirestoreMethods {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> uploadNameandAddress(
      {required String name, required String address}) async {
    try {
      UserDetailsModel user = UserDetailsModel(name: name, address: address);
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .set(user.getJson());
    } catch (e) {
      debugPrint('error = $e');
    }
  }

  Future<UserDetailsModel> getNameAndAddress() async {
    DocumentSnapshot<Map<String, dynamic>> snap = await firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .get();
    UserDetailsModel userModel =
        UserDetailsModel.getModelFromJson(snap.data() as dynamic);
    debugPrint('from cloud method==== ${userModel.name}');
    return userModel;
  }

  Future<void> addtoCart(ProductModel model, BuildContext ctx) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .collection("cart")
          .doc(model.uid)
          .set({'product': model.getJson(), "count": 1});
      Utils().showSnackBar(context: ctx, content: 'Added to cart');
    } catch (e) {
      Utils().showSnackBar(context: ctx, content: e.toString());
    }
  }

  Future<double> totalPricefromCart(BuildContext context) async {
    double totalPrice = 0;
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .collection("cart")
          .get();

      int count = 0;
      for (var doc in snapshot.docs) {
        count = doc.data()['count'];

        totalPrice = totalPrice + ((doc.data()['product']['cost']) * count);
      }
    } catch (e) {
      Utils().showSnackBar(context: context, content: '$e');
    }
    return totalPrice;
  }

  Future<void> uppdatetoCart(String uid, int count, BuildContext ctx) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .collection("cart")
          .doc(uid)
          .update({"count": count});
    } catch (e) {
      Utils().showSnackBar(context: ctx, content: e.toString());
    }
  }

  Future<void> deleteFromCart(ProductModel model, BuildContext ctx) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .collection("cart")
          .doc(model.uid)
          .delete();
      Utils().showSnackBar(context: ctx, content: 'Deleted from cart');
    } catch (e) {
      Utils().showSnackBar(context: ctx, content: e.toString());
    }
  }

  Future<void> addToOrders(ProductModel model) async {
    try {
      await firebaseFirestore
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .collection("orders")
          .add(model.getJson());
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<void> addAllToOrders() async {
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("cart")
        .get();
    snapshots.docs.forEach((item) async {
      ProductModel model = ProductModel.getModelFromJson(item['product']);
      await addToOrders(model);
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .collection("cart")
          .doc(model.uid)
          .delete();
    });
  }
}
