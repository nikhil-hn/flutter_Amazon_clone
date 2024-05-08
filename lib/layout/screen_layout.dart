import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/utils/color_theme.dart';
import 'package:amazon_clone/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({super.key});

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  PageController pageController = PageController();
  int currentPage = 0;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void changePage(int page) {
    pageController.jumpToPage(page);
    setState(() {
      currentPage = page;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserDetailsProvider>(context, listen: false).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: PageView(
            controller: pageController,
            children: screens,
          ),
          bottomNavigationBar: TabBar(
            indicator: const BoxDecoration(
              border: Border(
                top: BorderSide(color: activeCyanColor, width: 4),
              ),
            ),
            indicatorSize: TabBarIndicatorSize.label,
            onTap: changePage,
            tabs: [
              Tab(
                child: Icon(
                  Icons.home_outlined,
                  color: currentPage == 0 ? activeCyanColor : Colors.black,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.account_circle_outlined,
                  color: currentPage == 1 ? activeCyanColor : Colors.black,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.shopping_cart_outlined,
                  color: currentPage == 2 ? activeCyanColor : Colors.black,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.menu,
                  color: currentPage == 3 ? activeCyanColor : Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
