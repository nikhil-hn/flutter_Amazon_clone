import 'package:flutter/material.dart';

class Utils {
  Size getScreenSize(context) {
    return MediaQuery.of(context).size;
  }

  void showSnackBar({required BuildContext context, required String content}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Center(child: Text(content)),
      backgroundColor: Colors.orange,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), topRight: Radius.circular(5))),
    ));
  }
}
