import 'package:amazon_clone/utils/color_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:flutter/material.dart';

class ProfileScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfileScreenAppBar({super.key})
      : preferredSize = const Size.fromHeight(kAppBarHeight);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize(context);
    return Container(
      height: kAppBarHeight,
      width: screenSize.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: backgroundGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Image.asset(
              "assets/images/AmazonLogo.png",
              height: kAppBarHeight * 0.7,
            ),
          )
        ],
      ),
    );
  }
}
