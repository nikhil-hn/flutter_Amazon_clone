import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/utils/color_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsBar extends StatelessWidget {
  final double offset;
  final String screen;
  const UserDetailsBar({super.key, required this.offset, required this.screen});

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize(context);
    var container = Container(
      height: kAppBarHeight / 2,
      width: screenSize.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: lightBackgroundaGradient,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(
                Icons.location_on_outlined,
                color: Colors.grey[900],
              ),
            ),
            SizedBox(
              width: screenSize.width * 0.7,
              child: Consumer<UserDetailsProvider>(
                builder: (context, value, child) {
                  return Text(
                    "${context.watch<UserDetailsProvider>().userDetails.name} - ${context.watch<UserDetailsProvider>().userDetails.address}  ",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[900]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
    return screen == 'home'
        ? Positioned(
            top: -offset / 2,
            child: container,
          )
        : container;
  }
}
