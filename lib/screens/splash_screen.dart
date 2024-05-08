import 'package:amazon_clone/layout/screen_layout.dart';
import 'package:amazon_clone/screens/signin_screen.dart';
import 'package:amazon_clone/sharedPreference/shared_pref.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    load(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("assets/images/amazon_icon.jpg"),
      ),
    );
  }

  void load(context) async {
    bool status = await SharedPref().getloggInStatus();

    if (status) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const ScreenLayout(),
          ));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ));
    }
  }
}
