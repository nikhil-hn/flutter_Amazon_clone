import 'package:amazon_clone/screens/cart_screen.dart';
import 'package:amazon_clone/screens/home_screen.dart';
import 'package:amazon_clone/screens/more_screen.dart';
import 'package:amazon_clone/screens/profile_screen.dart';
import 'package:flutter/material.dart';

const double kAppBarHeight = 80;

const String amazonLogoUrl = "assets/images/AmazonLogo.png";

enum PaymentMethod { googlePay, phonePay, cashOnDelivery, card }

const List<Widget> screens = [
  HomeScreen(),
  ProfileScreen(),
  CartScreen(),
  MoreScreen()
];
const List<String> categoryLogo = [
  "assets/images/006.jpg",
  "assets/images/012.jpg",
  "assets/images/008.jpg",
  "assets/images/016.jpg",
  "assets/images/echodot.jpg"
];
const List<String> categoryList = [
  'Mobile',
  'Watch',
  'Laptop',
  "Suppliment",
  "Gadget"
];

const List<String> largeAds = [
  "assets/images/largeadd1.jpg",
  "assets/images/largeadd2.jpg",
  "assets/images/largeadd3.jpg",
  "assets/images/largeadd4.jpg",
];

const String amazonLogo =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png";
