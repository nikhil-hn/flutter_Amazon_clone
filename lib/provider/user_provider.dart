import 'package:amazon_clone/model/user_details_model.dart';
import 'package:amazon_clone/resources/cloudfirestore_methods.dart';
import 'package:flutter/material.dart';

class UserDetailsProvider extends ChangeNotifier {
  UserDetailsModel userDetails;

  UserDetailsProvider()
      : userDetails = UserDetailsModel(name: "loading", address: "loading");

  Future<void> getData() async {
    userDetails = await CloudFirestoreMethods().getNameAndAddress();

    notifyListeners();
  }
}
