import 'package:amazon_clone/screens/result_screen.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:amazon_clone/utils/product_list.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widget/product_showcase_list_view.dart';
import 'package:amazon_clone/widget/search_bar_widget.dart';
import 'package:amazon_clone/widget/user_details_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart%20';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();

  double offsetpix = 0;

  int currentAd = 0;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        offsetpix = controller.position.pixels;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize(context);

    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: true,
        hasBackButton: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                SizedBox(
                  height: kAppBarHeight / 2,
                  width: screenSize.width,
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ResultScreen(query: getAddData(currentAd)),
                            ));
                      },
                      onHorizontalDragEnd: (details) {
                        if (currentAd < largeAds.length - 1) {
                          setState(() {
                            currentAd++;
                          });
                        } else {
                          setState(() {
                            currentAd = 0;
                          });
                        }
                      },
                      child: Image.asset(
                        largeAds[currentAd],
                        fit: BoxFit.cover,
                        height: 200,
                        width: screenSize.width,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: Row(
                        children: indicator(largeAds.length),
                      ),
                    )
                  ],
                ),
                ProductShowCaseList(
                  title: "Deals for you",
                  list: productList.take(5).toList(),
                  screen: 'home',
                ),
                ProductShowCaseList(
                  title: "70 % off",
                  list: productList.reversed.take(5).toList(),
                  screen: 'home',
                )
              ],
            ),
          ),
          UserDetailsBar(
            offset: offsetpix,
            screen: 'home',
          )
        ],
      ),
    );
  }

  List<Widget> indicator(int length) {
    List<Widget> list = [];
    for (int i = 0; i < length; i++) {
      list.add(CircleAvatar(
        radius: 5,
        backgroundColor: i == currentAd ? Colors.blue : Colors.white,
      ));
      list.add(const SizedBox(
        width: 7,
      ));
    }
    return list;
  }

  String getAddData(int currentAd) {
    String query = '';
    switch (currentAd) {
      case 0:
        query = 'OnePlus 10 Pro 5G Mobile';
        break;
      case 1:
        query = 'Redmi Note 11 Mobile';
        break;
      case 2:
        query = 'Amazon Echo Dot';
        break;
      case 3:
        query = 'Laptops';
        break;
    }
    return query;
  }
}
