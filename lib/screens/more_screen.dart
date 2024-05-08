import 'package:amazon_clone/screens/result_screen.dart';
import 'package:amazon_clone/utils/color_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widget/search_bar_widget.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screeenSize = Utils().getScreenSize(context);
    return Scaffold(
      appBar: SearchBarWidget(isReadOnly: true, hasBackButton: false),
      body: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        children: List.generate(categoryLogo.length, (index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ResultScreen(query: categoryList[index]),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2,
                color: backgroundColor,
                child: Column(
                  children: [
                    SizedBox(
                      width: screeenSize.width * 0.4,
                      height: (screeenSize.height * 0.3) - 94,
                      child: Image.asset(categoryLogo[index]),
                    ),
                    Text(
                      categoryList[index],
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, letterSpacing: 0.5),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
