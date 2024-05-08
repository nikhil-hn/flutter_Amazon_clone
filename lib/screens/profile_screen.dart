import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/screens/signin_screen.dart';
import 'package:amazon_clone/sharedPreference/shared_pref.dart';
import 'package:amazon_clone/utils/color_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/product_list.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widget/custom_button.dart';
import 'package:amazon_clone/widget/product_showcase_list_view.dart';
import 'package:amazon_clone/widget/profile_screen_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const ProfileScreenAppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height - (kAppBarHeight / 2),
          width: screenSize.width,
          child: Column(
            children: [
              Container(
                height: kAppBarHeight / 2,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: lightBackgroundaGradient,
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Container(
                  height: kAppBarHeight / 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.000000000001)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 17),
                        child: Consumer<UserDetailsProvider>(
                          builder: (context, value, child) {
                            return RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Hello, ',
                                    style: TextStyle(
                                        color: Colors.grey[800], fontSize: 26),
                                  ),
                                  TextSpan(
                                    text: context
                                        .watch<UserDetailsProvider>()
                                        .userDetails
                                        .name,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              CustomMainButton(
                color: Colors.orange,
                isLoading: false,
                onPressed: () {
                  SharedPref().loggOut();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ));
                },
                child: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ProductShowCaseList(
                title: 'Your Orders',
                list: productList.reversed.take(3).toList(),
                screen: 'profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
